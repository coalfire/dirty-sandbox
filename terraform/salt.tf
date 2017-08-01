module "salt_rta" {
  source = "modules/route_table_association"

  count       = "${var.count["salt"]}"
  route_table = "${aws_route_table.dirty-sandbox.id}"
  subnet_id  = "${module.salt_subnet.subnet_id}"
}

module "salt_subnet" {
  source = "modules/subnet"


  region = "${var.region}"
  vpc_id = "${aws_vpc.dirty-sandbox.id}"
  vpc_cidr = "${var.vpc_cidr}"
  env = "${var.env}"
  name = "salt"
  
  subnet_index = 0

  count = "${var.count["salt"]}"

  availability_zones = "${var.availability_zones}"

}

module "salt_ec2" {
  source = "modules/ec2"

  count = "${var.count["salt"]}"

  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  region = "${var.region}"

  instance_name = "salt"
  env = "${var.env}"

  ami_id = "${var.centos7_ami["${var.region}"]}"
  ssh_key     = "${aws_key_pair.deployer.key_name}"

  has_public_ip = true

  security_group_ids = [
    "${aws_security_group.salt.id}",
    "${aws_security_group.ssh_manage.id}",
    "${aws_security_group.http_out.id}",
    "${aws_security_group.scan_me.id}",
]

  subnet_id   = "${module.salt_subnet.subnet_id}"
  subnet_cidr = "${module.salt_subnet.subnet_cidr}"

  user        = "centos"
  private_key = "${file("keys/deployer")}"

  user_data = "user_data/salt_master"
}

output "salt-public-address" {
  value = "${module.salt_ec2.public_ip}"
}

output "salt-ssh" {
  value = "ssh -i keys/deployer centos@${module.salt_ec2.public_ip}"
}

resource "aws_security_group" "salt" {
  name        = "salt"
  description = "salt from our VPC"
  vpc_id      = "${aws_vpc.dirty-sandbox.id}"

  ingress {
    from_port = 4505
    to_port   = 4506
    protocol  = "tcp"

    cidr_blocks = [
      "${aws_vpc.dirty-sandbox.cidr_block}",
    ]
  }

  tags {
    Name      = "salt"
    env       = "${var.env}"
    terraform = "yes"
  }
}

resource "aws_route53_record" "salt" {
  zone_id = "${aws_route53_zone.dirty-insec.zone_id}"
  name    = "salt"
  type    = "A"
  ttl     = "86400"
  records = ["${module.salt_ec2.private_ip}"]
}
