resource "aws_launch_configuration" "example" {
  name_prefix = "example"

  instance_type = "t2.micro"
  image_id      = "ami-05991b6a"

  key_name             = "${aws_key_pair.example.key_name}"
  iam_instance_profile = "${var.ec2-role-profile-id}"
  security_groups      = ["${var.ecs_security_group_id}"]

  user_data = "${data.template_cloudinit_config.example.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
