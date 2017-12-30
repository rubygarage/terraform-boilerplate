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
    elb_name       = "${module.elb.elb_name}"
    container_name = "example"
    container_port = 8080
  }
}
