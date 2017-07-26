resource "aws_subnet" "utils" {
  count                   = "${var.count}"
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.region}${var.availability_zones["${count.index}"]}"
  cidr_block              = "${cidrsubnet("${var.vpc_cidr}", 8, "${count.index * 128 }")}"
  map_public_ip_on_launch = false

  tags {
    Name      = "${format("utils-%02d", count.index + 1)}"
    env       = "${var.env}"
    terraform = "yes"
  }
}

resource "aws_subnet" "dirty-sandbox" {
  count                   = "${var.count}"
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.region}${var.availability_zones["${count.index}"]}"
  cidr_block              = "${cidrsubnet("${var.vpc_cidr}", 8, "${count.index * 128 + 1}")}"
  map_public_ip_on_launch = false

  tags {
    Name      = "${format("dirty-sandbox-%02d", count.index + 1)}"
    env       = "${var.env}"
    terraform = "yes"
  }
}
