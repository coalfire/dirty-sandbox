variable "region" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "env" {}

variable "count" {
  default = 1
}

variable "availability_zones" {
  type = "list"
}
