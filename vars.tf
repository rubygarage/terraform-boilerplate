variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "rds_example_staging_password" {}
variable "rds_example_production_password" {}

variable "ecs_example_rails_staging_image_tag" {
  default = "latest"
}

variable "ecs_example_nodejs_staging_image_tag" {
  default = "latest"
}

variable "ecs_example_rails_production_image_tag" {
  default = "latest"
}

variable "ecs_example_nodejs_production_image_tag" {
  default = "latest"
}
