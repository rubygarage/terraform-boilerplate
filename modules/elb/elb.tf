resource "aws_elb" "example" {
  name = "example"

  listener {
    lb_port     = 80
    lb_protocol = "http"

    instance_port     = 8080
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30

    target  = "HTTP:8080/"
    timeout = 5
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = ["${var.public-subnet-ids}"]
  security_groups = ["${var.elb-security-group-id}"]

  tags {
    Name = "example"
  }
}
