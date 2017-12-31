resource "aws_autoscaling_group" "example" {
  name                 = "example"
  launch_configuration = "${aws_launch_configuration.example.name}"

  vpc_zone_identifier = [
    "${var.private_subnet_ids}",
  ]

  min_size = 1
  max_size = 1

  tag {
    key   = "Name"
    value = "example"

    propagate_at_launch = true
  }
}
