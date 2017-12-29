resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"

  assume_role_policy = "${file("${path.module}/policies/ec2-role.json")}"
}

resource "aws_iam_instance_profile" "ec2-role" {
  name = "ec2-role"

  role = "${aws_iam_role.ec2-role.name}"
}

resource "aws_iam_policy_attachment" "ec2-role-attachment" {
  name = "ec2-role-attachment"

  roles      = ["${aws_iam_role.ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
