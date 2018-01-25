resource "aws_iam_user" "example_s3_production_manager" {
  name = "example-s3-production-manager"
}

resource "aws_iam_access_key" "example_s3_production_manager" {
  user = "${aws_iam_user.example_s3_production_manager.name}"
}

data "template_file" "example_s3_production_manager_policy" {
  template = "${file("iam-policies/example-s3-manager-policy.json")}"

  vars {
    S3_BUCKET_ARN = "${aws_s3_bucket.example_production.arn}"
  }
}

resource "aws_iam_user_policy" "example_s3_production_manager_policy" {
  name   = "example-s3-production-manager-policy"
  user   = "${aws_iam_user.example_s3_production_manager.name}"
  policy = "${data.template_file.example_s3_production_manager_policy.rendered}"
}
