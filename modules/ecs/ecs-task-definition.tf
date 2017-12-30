data "template_file" "example" {
  template = "${file("${path.module}/task-definitions/example.json")}"

  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.example.repository_url}", "https://", "")}"
    IMAGE_VERSION  = "${var.ecr-image-version}"
  }
}

resource "aws_ecs_task_definition" "example" {
  family = "example"

  container_definitions = "${data.template_file.example.rendered}"
}
