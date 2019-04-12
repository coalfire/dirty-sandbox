resource "aws_subnet" "subnet" {
  count                   = "${var.count}"
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.region}${var.availability_zones["${count.index}"]}"
  cidr_block              = "${cidrsubnet("${var.vpc_cidr}", 8, "${count.index * 128 + var.subnet_index}")}"
  ipv6_cidr_block         = "${cidrsubnet("${var.vpc_ipv6_cidr}", 8, "${count.index * 1024 + var.subnet_index}")}"
  map_public_ip_on_launch = false

  tags {
    Name      = "${format("%s-%02d", var.name, count.index + 1)}"
    env       = "${var.env}"
    terraform = "yes"
  }
}

