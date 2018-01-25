resource "aws_iam_server_certificate" "example" {
  name_prefix = "example"

  private_key      = "${file("ssl-certificates/example.com.key")}"
  certificate_body = "${file("ssl-certificates/example.com.crt")}"

  lifecycle {
    create_before_destroy = true
  }
}
