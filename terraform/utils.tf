module "utils_rta" {
  source = "modules/route_table_association"

  count       = "${var.count["utils"]}"
  route_table = "${aws_route_table.devel-tools.id}"
  subnet_ids  = "${module.subnets.utils_subnet_ids}"
}

module "salt" {
  source = "modules/salt"

  count      = "${var.count["utils"]}"

  env  = "${var.env}"

  centos7_ami = "${var.centos7_ami["${var.region}"]}"
  ssh_key     = "${aws_key_pair.deployer.key_name}"

  sg_salt             = "${aws_security_group.salt.id}"
  sg_ssh_manage       = "${aws_security_group.ssh_manage.id}"
  sg_universal_egress = "${aws_security_group.universal_egress.id}"

  subnet_ids   = "${module.subnets.utils_subnet_ids}"
  subnet_cidrs = "${module.subnets.utils_subnet_cidrs}"

  user        = "centos"
  private_key = "${file("keys/deployer")}"
}

output "salt-public-addresses" {
  value = "${module.salt.salt_public_ips}"
}

resource "aws_security_group" "salt" {
  name        = "salt"
  description = "salt from our VPC"
  vpc_id      = "${aws_vpc.devel-tools.id}"

  ingress {
    from_port = 4505
    to_port   = 4506
    protocol  = "tcp"

    cidr_blocks = [
      "${aws_vpc.devel-tools.cidr_block}",
    ]
  }

  tags {
    Name       = "salt"
    env = "${var.env}"
    terraform  = "yes"
  }
}
