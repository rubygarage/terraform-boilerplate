variable "ecs-cluster-name" {}
variable "ec2-role-profile-id" {}

variable "ecs-security-group-id" {}
variable "elb-security-group-id" {}

variable "public-subnet-ids" {
  type = "list"
}

variable "private-subnet-ids" {
  type = "list"
}
