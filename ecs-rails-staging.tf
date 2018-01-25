resource "aws_ecs_cluster" "example_rails_staging" {
  name = "example-rails-staging"
}

data "template_file" "example_rails_staging_task_definition" {
  template = "${file("task-definitions/example-rails-staging.json")}"

  vars = {
    IMAGE_TAG = "${var.ecs_example_rails_staging_image_tag}"
  }
}

resource "aws_ecs_task_definition" "example_rails_staging" {
  family = "example-rails-staging"

  container_definitions = "${data.template_file.example_rails_staging_task_definition.rendered}"
}

resource "aws_ecs_service" "example_rails_staging" {
  name            = "example-rails-staging"
  cluster         = "${aws_ecs_cluster.example_rails_staging.id}"
  task_definition = "${aws_ecs_task_definition.example_rails_staging.arn}"

  desired_count = 1

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  iam_role   = "${aws_iam_role.ecs_role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs_attachment"]

  load_balancer {
    elb_name       = "${aws_elb.example_rails_staging.name}"
    container_name = "example-rails-staging"
    container_port = 80
  }
}
