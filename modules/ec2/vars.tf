variable "ecs-cluster-name" {}
variable "ec2-role-profile-id" {}

variable "ecs_security_group_id" {}
variable "elb_security_group_id" {}

variable "public_subnet_ids" {
  type = "list"
}

variable "private_subnet_ids" {
  type = "list"
}
