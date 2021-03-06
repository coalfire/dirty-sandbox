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

  private_ip     = "${cidrhost("${var.subnet_cidr}", count.index + "${var.ip_offset}")}"
  associate_public_ip_address = "${var.has_public_ip}"

  user_data = "${file(var.user_data)}"

  tags {
    Name      = "${var.instance_name}-${format("%02d", count.index + 1)}"
    env       = "${var.env}"
    terraform = "yes"
  }
}

resource "aws_eip" "elastic_ip" {
  vpc = true
}


resource "aws_eip_association" "primary" {
  network_interface_id = "${aws_instance.ec2_instance.network_interface_id}"
  allocation_id = "${aws_eip.elastic_ip.id}"
}

resource "aws_network_interface" "secondary" {
  count = "${var.secondary_network_interface_count}"

  subnet_id = "${var.subnet_id}"
  description = "secondary network interface"

  private_ips     = ["${cidrhost("${var.subnet_cidr}", count.index + "${var.ip_offset}" + 1)}"]
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

resource "aws_eip" "secondary" {
  vpc = true
}

resource "aws_eip_association" "secondary" {
  count         = "${var.secondary_network_interface_count}"
  network_interface_id   = "${aws_network_interface.secondary.id}"
  allocation_id = "${aws_eip.secondary.id}"
}

