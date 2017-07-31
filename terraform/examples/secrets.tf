variable "aws_access_key" {
  default = "AWS_ACCESS_KEY_CHANGE_ME"
}

variable "aws_secret_key" {
  default = "AWS_SECRET_KEY_CHANGE_ME"
}

variable "mgmt_cidrs" {
  type = "list"

  default = [
    "MY_PUBLIC_CIDR_BLOCK1_CHANGEME",
    "MY_PUBLIC_CIDR_BLOCK2_CHANGEME",
  ]
}

variable "scanner_cidrs" {
  type = "list"

  default = [
    "MY_SCANNER_PUBLIC_CIDR_BLOCK1_CHANGEME",
    "MY_SCANNER_PUBLIC_CIDR_BLOCK2_CHANGEME",
  ]
}
