variable "region" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "vpc_ipv6_cidr" {}
variable "env" {}
variable "name" {}

variable "subnet_index" {
  default = 0
}

variable "count" {
  default = 1
}

variable "availability_zones" {
  type = "list"
  default = ["a", "b"]
}
