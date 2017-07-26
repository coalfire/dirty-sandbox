provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_vpc" "dirty-sandbox" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name       = "dirty-sandbox"
    env = "${var.env}"
    terraform  = "yes"
    env
  }
}

module "subnets" {
  source = "modules/subnets"

  region             = "${var.region}"
  count              = "${var.count["utils"]}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.devel-tools.id}"
  availability_zones = "${var.availability_zones}"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = "${file("keys/deployer.pub")}"
}
