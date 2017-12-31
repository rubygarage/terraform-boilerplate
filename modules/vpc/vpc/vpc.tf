resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block}"
  instance_tenancy     = "default"
  enable_classiclink   = false
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}"
  }
}
