provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "ec2_instance" {
  ami       = "${var.ami_id}"
  count     = "${var.count}"
  subnet_id = "${var.subnet_id}"

  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_key}"

  vpc_security_group_ids = [ "${var.security_group_ids}" ]

  associate_public_ip_address = "${var.has_public_ip}"
  private_ip                  = "${cidrhost("${var.subnet_cidr}", count.index + "${var.ip_offset}")}"

  user_data = "${file(var.user_data)}"

  tags {
    Name      = "${var.instance_name}-${format("%02d", count.index + 1)}"
    env       = "${var.env}"
    terraform = "yes"
  }
}

resource "aws_eip" "elastic_ip" {
  instance = "${aws_instance.ec2_instance.id}"
  vpc = true
}

resource "aws_network_interface" "secondary" {
  count = "${var.secondary_network_interface_count}"

  subnet_id = "${var.subnet_id}"
  description = "secondary network interface"

  private_ips     = ["${cidrhost("${var.subnet_cidr}", count.index + "${var.ip_offset}")} + 1"]
  security_groups = [ "${var.security_group_ids}" ]

  attachment {
    instance     = "${aws_instance.ec2_instance.id}"
    device_index = 1
  }

  tags {
    Name      = "secondary-${var.instance_name}-${format("%02d", count.index + 1)}"
    env       = "${var.env}"
    terraform = "yes"
  }
}
