resource "aws_ecs_service" "example" {
  name            = "example"
  iam_role        = "${var.ecs-role-arn}"
  cluster         = "${aws_ecs_cluster.example.id}"
  task_definition = "${aws_ecs_task_definition.example.arn}"

  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  load_balancer {
    elb_name       = "${var.elb-name}"
    container_name = "example"
    container_port = 8080
  }
}
