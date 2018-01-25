resource "aws_iam_role" "ecs_role" {
  name = "ecs-role"

  assume_role_policy = "${file("iam-policies/example-ecs-role.json")}"
}

resource "aws_iam_policy_attachment" "ecs_attachment" {
  name = "ecs-attachment"

  roles      = ["${aws_iam_role.ecs_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
