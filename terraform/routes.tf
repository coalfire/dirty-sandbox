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

  tags {
    Name      = "dirty-sandbox"
    env       = "${var.env}"
    terraform = "yes"
  }
}
