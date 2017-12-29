output "ec2-role-arn" {
  value = "${aws_iam_role.ec2-role.arn}"
}

output "ecs-role-arn" {
  value = "${aws_iam_role.ecs-role.arn}"
}

output "ec2-role-profile-id" {
  value = "${aws_iam_instance_profile.ec2-role.id}"
}
