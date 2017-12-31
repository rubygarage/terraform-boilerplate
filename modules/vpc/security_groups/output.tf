output "elb_security_group_id" {
  value = "aws_security_group.elb.id"
}

output "ecs_security_group_id" {
  value = "aws_security_group.ecs.id"
}
