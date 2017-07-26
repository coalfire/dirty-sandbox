resource "aws_instance" "salt" {
  count = "${var.count}"

  ami           = "${var.centos7_ami}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key}"
  subnet_id     = "${var.subnet_ids[count.index]}"

  vpc_security_group_ids = [
    "${var.sg_salt}",
    "${var.sg_ssh_manage}",
    "${var.sg_universal_egress}",
  ]

  associate_public_ip_address = true
  private_ip                  = "${cidrhost("${var.subnet_cidrs[count.index]}", 4)}"
  source_dest_check           = true

  user_data = "${file("${path.module}/files/init")}"

  connection {
    user        = "${var.user}"
    private_key = "${var.private_key}"
  }

  provisioner "file" {
    source      = "keys/master"
    destination = "/home/${var.user}/master.pem"
  }

  provisioner "file" {
    source      = "keys/master.pub"
    destination = "/home/${var.user}/master.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname --static ${format("salt-%02d", count.index + 1)}",
      "sudo mkdir -p /etc/salt/pki/master/",
      "sudo mv /home/${var.user}/master.pem /etc/salt/pki/master/master.pem",
      "sudo mv /home/${var.user}/master.pub /etc/salt/pki/master/master.pub",
    ]
  }

  tags {
    Name       = "${format("salt-%02d", count.index + 1)}"
    env = "${var.env}"
    terraform  = "yes"
  }
}
