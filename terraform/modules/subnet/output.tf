output "subnet_id" {
  value = "${aws_subnet.subnet.0.id}"
}

output "subnet_cidr" {
  value = "${aws_subnet.subnet.0.cidr_block}"
}
