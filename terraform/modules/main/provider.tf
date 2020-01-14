provider "aws" {
  # Profile is not needed for Terraform Cloud
  # profile = "terraform-rails"
  version = "~> 2.34"
  region  = var.region
}

provider "template" {
  version = "~> 2.1"
}
