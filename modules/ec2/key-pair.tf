resource "aws_key_pair" "example" {
  key_name = "example"

  public_key = "${file("${path.module}/ssh-keys/key.pub")}"
}
