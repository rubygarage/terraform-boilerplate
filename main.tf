module "ec2" {
  source = "./modules/ec2"

  ecs-cluster-name    = "${module.ecs.ecs_cluster_name}"
  ec2-role-profile-id = "${module.iam.ec2-role-profile-id}"

  ecs-security-group-id = "${module.vpc.ecs-security-group-id}"
  elb-security-group-id = "${module.vpc.elb-security-group-id}"

  public-subnet-ids  = "${module.vpc.public-subnet-ids}"
  private-subnet-ids = "${module.vpc.private-subnet-ids}"
}

module "ecs" {
  source = "./modules/ecs"

  ecs-role-arn      = "${module.iam.ecs-role-arn}"
  elb-name          = "${module.elb.elb-name}"
  ecr-image-version = "${var.ECR_IMAGE_VERSION}"
}

module "elb" {
  source = "./modules/elb"

  public-subnet-ids     = "${module.vpc.public-subnet-ids}"
  elb-security-group-id = "${module.vpc.elb-security-group-id}"
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
}
