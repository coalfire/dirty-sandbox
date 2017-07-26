output "utils_subnet_ids" {
  value = ["${aws_subnet.utils.*.id}"]
}

output "utils_subnet_cidrs" {
  value = ["${aws_subnet.utils.*.cidr_block}"]
}

output "dirty-sandbox_subnet_ids" {
  value = ["${aws_subnet.dirty-sandbox.*.id}"]
}

output "dirty-sandbox_subnet_cidrs" {
  value = ["${aws_subnet.dirty-sandbox.*.cidr_block}"]
}
