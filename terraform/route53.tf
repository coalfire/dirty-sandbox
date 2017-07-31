resource "aws_route53_zone" "dirty-insec" {
  name   = "dirty.insec."
  vpc_id = "${aws_vpc.dirty-sandbox.id}"
  force_destroy = false

  tags {
    Name       = "dirty-insec"
    env = "${var.env}"
    terraform  = "yes"
  }
}

output "dirty-insec-zone-id" {
  value = "${aws_route53_zone.dirty-insec.zone_id}"
}

resource "aws_route53_record" "salt" {
  zone_id = "${aws_route53_zone.dirty-insec.zone_id}"
  name    = "salt.develtools.sec"
  type    = "A"
  ttl     = "86400"
  records = ["${module.salt_ec2.public_ips[0]}"]
}
