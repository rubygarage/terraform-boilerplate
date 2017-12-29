data "template_file" "example" {
  template = "${file("templates/example.json")}"

  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.example.repository_url}", "https://", "")}"
    IMAGE_VERSION  = "${var.ECR_IMAGE_VERSION}"
  }
}

resource "aws_ecs_task_definition" "example" {
  family = "example"

  container_definitions = "${data.template_file.example.rendered}"
}

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

  subnets         = ["${aws_subnet.example-public.id}"]
  security_groups = ["${aws_security_group.example-elb.id}"]

  tags {
    Name = "example"
  }
}

resource "aws_ecs_service" "example" {
  name            = "example"
  iam_role        = "${module.iam.ecs-role-arn}"
  cluster         = "${aws_ecs_cluster.example.id}"
  task_definition = "${aws_ecs_task_definition.example.arn}"

  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  depends_on = ["module.iam"]

  load_balancer {
    elb_name       = "${aws_elb.example.name}"
    container_name = "example"
    container_port = 8080
  }
}
