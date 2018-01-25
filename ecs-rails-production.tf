resource "aws_ecs_cluster" "example_rails_production" {
  name = "example-rails-production"
}

data "template_file" "example_rails_production_task_definition" {
  template = "${file("task-definitions/example-rails-production.json")}"

  vars = {
    IMAGE_TAG = "${var.ecs_example_rails_production_image_tag}"
  }
}

resource "aws_ecs_task_definition" "example_rails_production" {
  family = "example-rails-production"

  container_definitions = "${data.template_file.example_rails_production_task_definition.rendered}"
}

resource "aws_ecs_service" "example_rails_production" {
  name            = "example-rails-production"
  cluster         = "${aws_ecs_cluster.example_rails_production.id}"
  task_definition = "${aws_ecs_task_definition.example_rails_production.arn}"

  desired_count = 1

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  iam_role   = "${aws_iam_role.ecs_role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs_attachment"]

  load_balancer {
    elb_name       = "${aws_elb.example_rails_production.name}"
    container_name = "example-rails-production"
    container_port = 80
  }
}
