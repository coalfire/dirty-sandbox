resource "aws_route_table_association" "rta" {
  count          = "${var.count}"
  route_table_id = "${var.route_table}"
  subnet_id      = "${var.subnet_ids[count.index]}"
}
