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
  ]

  subnet_id   = "${module.target_subnet.subnet_id}"
  subnet_cidr = "${module.target_subnet.subnet_cidr}"

  user = "centos"
  private_key = "${file("keys/deployer")}"
  
  user_data = "user_data/insecure_services"
}

