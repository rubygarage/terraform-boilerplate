module "vpc" {
  source = "./vpc"

  name       = "${var.name}"
  cidr_block = "${var.vpc_cidr_block}"
}

module "public_subnets" {
  source = "./subnets"

  type               = "public"
  name               = "${var.name}"
  vpc_id             = "${module.vpc.vpc_id}"
  availability_zones = ["${var.vpc_subnet_availability_zones}"]
  cidr_blocks        = ["${var.vpc_public_subnet_cidr_blocks}"]
}

module "private_subnets" {
  source = "./subnets"

  type               = "private"
  name               = "${var.name}"
  vpc_id             = "${module.vpc.vpc_id}"
  availability_zones = ["${var.vpc_subnet_availability_zones}"]
  cidr_blocks        = ["${var.vpc_private_subnet_cidr_blocks}"]
}

module "internet_gateway" {
  source = "./internet_gateway"

  name              = "${var.name}"
  vpc_id            = "${module.vpc.vpc_id}"
  public_subnet_ids = ["${module.public_subnets.subnet_ids}"]
}

module "nat_gateway" {
  source = "./nat_gateway"

  name               = "${var.name}"
  vpc_id             = "${module.vpc.vpc_id}"
  public_subnet_ids  = ["${module.public_subnets.subnet_ids}"]
  private_subnet_ids = ["${module.private_subnets.subnet_ids}"]
}

module "security_groups" {
  source = "./security_groups"

  name   = "${var.name}"
  vpc_id = "${module.vpc.vpc_id}"
}
