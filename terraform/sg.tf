resource "aws_security_group" "ssh_manage" {
  name        = "ssh_manage"
  description = "ssh from management subnets"
  vpc_id      = "${aws_vpc.dirty-sandbox.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [ "${var.mgmt_cidrs}" ]
  }

  tags {
    Name       = "ssh_manage"
    env = "${var.env}"
    terraform  = "yes"
  }
}

resource "aws_security_group" "universal_egress" {
  name        = "universal_egress"
  description = "out to the universe on all ports"
  vpc_id      = "${aws_vpc.dirty-sandbox.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name       = "universal_egress"
    env = "${var.env}"
    terraform  = "yes"
  }
}

resource "aws_security_group" "scan_me" {
  name = "scan_me"
  description = "white list a scanning service"
  vpc_id      = "${aws_vpc.dirty-sandbox.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = "${var.scanner_cidrs}"
  }

  tags {
    Name = "scan_me"
    env = "${var.env}"
    terraform  = "yes"
  }
}
