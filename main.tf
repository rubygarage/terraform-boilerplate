module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
}
