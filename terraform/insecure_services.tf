module "insecure_services" {
  source = "modules/ec2"

  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  region = "${var.region}"

  instance_name = "insecure_services"
  env = "${var.env}"

  ami_id = "${var.centos7_ami["${var.region}"]}"
  ssh_key = "${aws_key_pair.deployer.key_name}"

  has_public_ip = true

  security_group_ids = [
    "${aws_security_group.ssh_manage.id}",
    "${aws_security_group.scan_me.id}",
    "${aws_security_group.http_out.id}",
    "${aws_security_group.salt_out.id}",
  ]

  subnet_id   = "${module.target_subnet.subnet_id}"
  subnet_cidr = "${module.target_subnet.subnet_cidr}"
  ip_offset = "${var.ip_offset["insecure_services"]}"

  user = "centos"
  private_key = "${file("keys/deployer")}"
  
  user_data = "user_data/insecure_services"
}

output "insecure_services-public-address" {
  value = "${module.insecure_services.public_ip}"
}

output "insecure_services-ssh" {
  value = "ssh -i keys/deployer centos@${module.insecure_services.public_ip}"
}
