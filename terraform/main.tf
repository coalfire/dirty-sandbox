provider "aws" {
  region     = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

resource "aws_vpc" "dirty-sandbox" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true

  tags {
    Name      = "dirty-sandbox"
    env       = "${var.env}"
    terraform = "yes"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = "${file("keys/deployer.pub")}"
}

resource "aws_route53_zone" "dirty-insec" {
  name   = "dirty.insec."
  vpc_id = "${aws_vpc.dirty-sandbox.id}"
  force_destroy = false

  tags {
    Name       = "dirty-insec"
    env = "${var.env}"
    terraform  = "yes"
  }
}

output "dirty-insec-zone-id" {
  value = "${aws_route53_zone.dirty-insec.zone_id}"
}

resource "aws_internet_gateway" "dirty-sandbox" {
  vpc_id = "${aws_vpc.dirty-sandbox.id}"

  tags {
    Name      = "dirty-sandbox"
    env       = "${var.env}"
    terraform = "yes"
  }
}

resource "aws_route_table" "dirty-sandbox" {
  vpc_id = "${aws_vpc.dirty-sandbox.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dirty-sandbox.id}"
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = "${aws_internet_gateway.dirty-sandbox.id}"
  }

  tags {
    Name      = "dirty-sandbox"
    env       = "${var.env}"
    terraform = "yes"
  }
}
