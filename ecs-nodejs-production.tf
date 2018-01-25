resource "aws_ecs_cluster" "example_nodejs_production" {
  name = "example-nodejs-production"
}

data "template_file" "example_nodejs_production_task_definition" {
  template = "${file("task-definitions/example-nodejs-production.json")}"

  vars = {
    IMAGE_TAG = "${var.ecs_example_nodejs_production_image_tag}"
  }
}

resource "aws_ecs_task_definition" "example_nodejs_production" {
  family = "example-nodejs-production"

  container_definitions = "${data.template_file.example_nodejs_production_task_definition.rendered}"
}

resource "aws_ecs_service" "example_nodejs_production" {
  name            = "example-nodejs-production"
  cluster         = "${aws_ecs_cluster.example_nodejs_production.id}"
  task_definition = "${aws_ecs_task_definition.example_nodejs_production.arn}"

  desired_count = 1

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  iam_role   = "${aws_iam_role.ecs_role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs_attachment"]

  load_balancer {
    elb_name       = "${aws_elb.example_nodejs_production.name}"
    container_name = "example-nodejs-production"
    container_port = 80
  }
}
