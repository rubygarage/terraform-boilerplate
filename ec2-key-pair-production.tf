resource "aws_key_pair" "example_production" {
  key_name = "example-production"

  public_key = "${file("ssh-keys/example-production.pub")}"
}
