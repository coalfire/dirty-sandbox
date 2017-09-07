output "public_ip" {
  value = "${aws_instance.ec2_instance.0.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.ec2_instance.0.private_ip}"
}
