resource "aws_s3_bucket" "example_staging" {
  bucket = "example-staging"
  acl    = "private"

  tags {
    Name = "example-staging"
  }
}
