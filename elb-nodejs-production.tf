resource "aws_elb" "example_nodejs_production" {
  name = "example-nodejs-production"

  listener {
    lb_port     = 80
    lb_protocol = "http"

    instance_port     = 80
    instance_protocol = "http"
  }

  listener {
    lb_port     = 443
    lb_protocol = "https"

    instance_port     = 80
    instance_protocol = "http"

    ssl_certificate_id = "${aws_iam_server_certificate.example.arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 6
    interval            = 15

    target  = "HTTP:80/"
    timeout = 10
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300

  subnets = [
    "${aws_subnet.example_public_a.id}",
    "${aws_subnet.example_public_b.id}",
    "${aws_subnet.example_public_c.id}",
  ]

  security_groups = [
    "${aws_security_group.example_nodejs_production_elb.id}",
  ]

  tags {
    Name = "example-nodejs-production"
  }
}
