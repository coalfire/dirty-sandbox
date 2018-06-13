variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}

variable "instance_name" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "user_data" {
  default = ""
}

variable "ami_id" {}

variable "count" {
  default = 1
}

variable "ssh_key" {}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "has_public_ip" {
  default = "false"
}

variable "subnet_id" {}
variable "subnet_cidr" {}

variable "ip_offset" {
  description = "where to start ips in the cidr block"
  default     = 4
}

variable "secondary_network_interface_count" {
  description = "how many additional network interfaces to attach to instance"
  default = 0
}

variable "user" {
  default = "root"
}

variable "private_key" {}


variable "env" {
  default = "qa"
}
