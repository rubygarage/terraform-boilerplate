resource "aws_iam_role" "ecs-role" {
  name = "ecs-role"

  assume_role_policy = "${file("${path.module}/policies/ecs-role.json")}"
}

resource "aws_iam_policy_attachment" "ecs-role-attachment" {
  name = "ecs-role-attachment"

  roles      = ["${aws_iam_role.ecs-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
