variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "ECR_IMAGE_VERSION" {
  default = "release-1"
}

variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
  type = "map"

  default = {
    eu-central-1 = "ami-05991b6a"
  }
}

variable "PRIVATE_KEY_PATH" {
  default = "key"
}

variable "PUBLIC_KEY_PATH" {
  default = "key.pub"
}
