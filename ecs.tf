resource "aws_key_pair" "example" {
  key_name   = "example"
  public_key = "${file("${var.PUBLIC_KEY_PATH}")}"
}

resource "aws_ecs_cluster" "example" {
  name = "example"
}

resource "aws_launch_configuration" "example" {
  name_prefix = "example"

  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.example.key_name}"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  iam_instance_profile = "${module.iam.ec2-role-profile-id}"

  security_groups = ["${module.vpc.ecs-security-group-id}"]
  user_data       = "#!/bin/bash\necho 'ECS_CLUSTER=${aws_ecs_cluster.example.name}' > /etc/ecs/ecs.config\nstart ecs"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                 = "example"
  launch_configuration = "${aws_launch_configuration.example.name}"

  vpc_zone_identifier = [
    "${module.vpc.private-subnet-a-id}",
    "${module.vpc.private-subnet-b-id}",
    "${module.vpc.private-subnet-c-id}",
  ]

  min_size = 1
  max_size = 1

  tag {
    key   = "Name"
    value = "example"

    propagate_at_launch = true
  }
}
