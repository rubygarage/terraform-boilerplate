resource "aws_s3_bucket" "example_production" {
  bucket = "example-production"
  acl    = "private"

  tags {
    Name = "example-production"
  }
}
