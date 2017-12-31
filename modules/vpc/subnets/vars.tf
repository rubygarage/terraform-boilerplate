variable "name" {}
variable "vpc_id" {}

variable "cidr_blocks" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "type" {
  default = "private"
}
