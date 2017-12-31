variable "name" {}
variable "vpc_cidr_block" {}

variable "vpc_subnet_availability_zones" {
  type = "list"
}

variable "vpc_public_subnet_cidr_blocks" {
  type = "list"
}

variable "vpc_private_subnet_cidr_blocks" {
  type = "list"
}
