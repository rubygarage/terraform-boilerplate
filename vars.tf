variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  default = "eu-central-1"
}

variable "ecr_image_version" {
  default = "release-1"
}

variable "name" {
  default = "example"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_subnet_availability_zones" {
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",
  ]
}

variable "vpc_public_subnet_cidr_blocks" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
}

variable "vpc_private_subnet_cidr_blocks" {
  default = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
  ]
}
