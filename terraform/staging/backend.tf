# Backend can't use variables, values have to be hardcoded

terraform {
  # backend "s3" {
  #   profile = "terraform-rails"
  #
  #   bucket         = "terraform-rails-tfstate"
  #   region         = "eu-north-1"
  #   key            = "staging/terraform.tfstate"
  #   encrypt        = true
  #   dynamodb_table = "terraform-rails-terraform-locks"
  # }

  backend "remote" {
    organization = "terraform-rails"

    workspaces {
      name = "staging"
    }
  }
}
