data "template_file" "shell-script" {
  template = "${file("${path.module}/scripts/init.sh")}"

  vars {
    ECS_CLUSTER = "${var.ecs-cluster-name}"
  }
}

data "template_cloudinit_config" "example" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.shell-script.rendered}"
  }
}
