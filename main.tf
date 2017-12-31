module "ec2" {
  source = "./modules/ec2"

  ecs-cluster-name    = "${module.ecs.ecs_cluster_name}"
  ec2-role-profile-id = "${module.iam.ec2-role-profile-id}"

  ecs_security_group_id = "${module.vpc.ecs_security_group_id}"
  elb_security_group_id = "${module.vpc.elb_security_group_id}"

  public_subnet_ids  = "${module.vpc.public_subnet_ids}"
  private_subnet_ids = "${module.vpc.private_subnet_ids}"
}

module "ecs" {
  source = "./modules/ecs"

  ecs-role-arn      = "${module.iam.ecs-role-arn}"
  elb-name          = "${module.elb.elb-name}"
  ecr-image-version = "${var.ecr_image_version}"
}

module "elb" {
  source = "./modules/elb"

  public_subnet_ids     = "${module.vpc.public_subnet_ids}"
  elb_security_group_id = "${module.vpc.elb_security_group_id}"
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"

  name                          = "${var.name}"
  vpc_cidr_block                = "${var.vpc_cidr_block}"
  vpc_subnet_availability_zones = "${var.vpc_subnet_availability_zones}"

  vpc_public_subnet_cidr_blocks  = "${var.vpc_public_subnet_cidr_blocks}"
  vpc_private_subnet_cidr_blocks = "${var.vpc_private_subnet_cidr_blocks}"
}
