resource "aws_key_pair" "example_staging" {
  key_name = "example-staging"

  public_key = "${file("ssh-keys/example-staging.pub")}"
}
