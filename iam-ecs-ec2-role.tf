resource "aws_iam_role" "ecs_ec2_role" {
  name = "ecs-ec2-role"

  assume_role_policy = "${file("iam-policies/example-ecs-ec2-role.json")}"
}

resource "aws_iam_instance_profile" "ecs_ec2_role" {
  name = "ecs-ec2-role"
  role = "${aws_iam_role.ecs_ec2_role.name}"
}

resource "aws_iam_policy_attachment" "ecs_ec2_attachment" {
  name       = "ecs-ec2-attachment"
  roles      = ["${aws_iam_role.ecs_ec2_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
