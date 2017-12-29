resource "aws_iam_role" "ecs-ec2-role" {
  name               = "ecs-ec2-role"
  assume_role_policy = "${file("aim-policies/ecs-ec2-role.json")}"
}

resource "aws_iam_instance_profile" "ecs-ec2-role" {
  name = "ecs-ec2-role"
  role = "${aws_iam_role.ecs-ec2-role.name}"
}

resource "aws_iam_policy_attachment" "ecs-ec2-attachment" {
  name       = "ecs-ec2-attachment"
  roles      = ["${aws_iam_role.ecs-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ecs-service-role" {
  name               = "ecs-service-role"
  assume_role_policy = "${file("aim-policies/ecs-service-role.json")}"
}

resource "aws_iam_policy_attachment" "ecs-service-attachment" {
  name       = "ecs-service-attachment"
  roles      = ["${aws_iam_role.ecs-service-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
