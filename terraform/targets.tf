module "target_subnet" {
  source = "modules/subnet"

  region = "${var.region}"
  vpc_id = "${aws_vpc.dirty-sandbox.id}"
  vpc_cidr = "${var.vpc_cidr}"
  env = "${var.env}"
  name = "public_target"
  
  subnet_index = 1

  count = 1

  availability_zones = "${var.availability_zones}"
}

module "target_rta" {
  source = "modules/route_table_association"

  route_table = "${aws_route_table.dirty-sandbox.id}"
  subnet_id  = "${module.target_subnet.subnet_id}"
}

