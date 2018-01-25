resource "aws_ecs_cluster" "example_nodejs_staging" {
  name = "example-nodejs-staging"
}

data "template_file" "example_nodejs_staging_task_definition" {
  template = "${file("task-definitions/example-nodejs-staging.json")}"

  vars = {
    IMAGE_TAG = "${var.ecs_example_nodejs_staging_image_tag}"
  }
}

resource "aws_ecs_task_definition" "example_nodejs_staging" {
  family = "example-nodejs-staging"

  container_definitions = "${data.template_file.example_nodejs_staging_task_definition.rendered}"
}

resource "aws_ecs_service" "example_nodejs_staging" {
  name            = "example-nodejs-staging"
  cluster         = "${aws_ecs_cluster.example_nodejs_staging.id}"
  task_definition = "${aws_ecs_task_definition.example_nodejs_staging.arn}"

  desired_count = 1

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  iam_role   = "${aws_iam_role.ecs_role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs_attachment"]

  load_balancer {
    elb_name       = "${aws_elb.example_nodejs_staging.name}"
    container_name = "example-nodejs-staging"
    container_port = 80
  }
}
