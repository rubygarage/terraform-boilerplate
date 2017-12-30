module "ec2" {
  source = "./modules/ec2"

  ecs-cluster-name    = "example"                           # TODO: replace!!!
  ec2-role-profile-id = "${module.iam.ec2-role-profile-id}"

  ecs-security-group-id = "${module.vpc.ecs-security-group-id}"
  elb-security-group-id = "${module.vpc.elb-security-group-id}"

  public-subnet-ids  = "${module.vpc.public-subnet-ids}"
  private-subnet-ids = "${module.vpc.private-subnet-ids}"
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
}
