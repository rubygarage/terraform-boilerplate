data "template_file" "example_nodejs_production_script" {
  template = "${file("scripts/init.sh")}"

  vars {
    ECS_CLUSTER = "${aws_ecs_cluster.example_nodejs_production.name}"
  }
}

data "template_cloudinit_config" "example_nodejs_production" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.example_nodejs_production_script.rendered}"
  }
}

resource "aws_launch_configuration" "example_nodejs_production" {
  name_prefix = "example-nodejs-production"

  instance_type = "t2.micro"
  image_id      = "ami-1d46df64"

  key_name             = "${aws_key_pair.example_production.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_ec2_role.id}"
  security_groups      = ["${aws_security_group.example_nodejs_production_ecs.id}"]

  user_data = "${data.template_cloudinit_config.example_nodejs_production.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example_nodejs_production" {
  name                 = "example-nodejs-production"
  launch_configuration = "${aws_launch_configuration.example_nodejs_production.name}"

  vpc_zone_identifier = [
    "${aws_subnet.example_private_a.id}",
    "${aws_subnet.example_private_b.id}",
    "${aws_subnet.example_private_c.id}",
  ]

  min_size = 1
  max_size = 1

  tag {
    key   = "Name"
    value = "example-nodejs-production"

    propagate_at_launch = true
  }
}
