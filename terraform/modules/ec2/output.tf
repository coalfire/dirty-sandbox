output "public_ips" {
  value = "${aws_instance.ec2_instance.*.public_ip}"
}

output "private_ips" {
  value = "${aws_instance.ec2_instance.*.private_ip}"
}
