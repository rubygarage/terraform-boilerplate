output "elb_security_group_id" {
  value = "${module.security_groups.elb_security_group_id}"
}

output "ecs_security_group_id" {
  value = "${module.security_groups.ecs_security_group_id}"
}

output "public_subnet_ids" {
  value = ["${module.public_subnets.subnet_ids}"]
}

output "private_subnet_ids" {
  value = ["${module.private_subnets.subnet_ids}"]
}
