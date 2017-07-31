provider "aws" {
  region     = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

resource "aws_vpc" "dirty-sandbox" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name      = "dirty-sandbox"
    env       = "${var.env}"
    terraform = "yes"
  }
}

module "target_subnet" {
  source = "modules/subnet"

  region = "${var.region}"
  vpc_id = "${aws_vpc.dirty-sandbox.id}"
  vpc_cidr = "${var.vpc_cidr}"
  env = "${var.env}"
  name = "salt"
  
  subnet_index = 1

  count = 1

  availability_zones = "${var.availability_zones}"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = "${file("keys/deployer.pub")}"
}
