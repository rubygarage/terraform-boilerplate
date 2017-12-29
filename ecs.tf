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
  iam_instance_profile = "${aws_iam_instance_profile.ecs-ec2-role.id}"

  security_groups = ["${aws_security_group.example-ecs.id}"]
  user_data       = "#!/bin/bash\necho 'ECS_CLUSTER=${aws_ecs_cluster.example.name}' > /etc/ecs/ecs.config\nstart ecs"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                 = "example"
  vpc_zone_identifier  = ["${aws_subnet.example-private.id}"]
  launch_configuration = "${aws_launch_configuration.example.name}"

  min_size = 1
  max_size = 1

  tag {
    key   = "Name"
    value = "example"

    propagate_at_launch = true
  }
}
