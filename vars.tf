variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "ECR_IMAGE_VERSION" {
  default = "release-1"
}

variable "AWS_REGION" {
  default = "eu-central-1"
}
