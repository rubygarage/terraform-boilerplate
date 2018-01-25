resource "aws_iam_user" "example_s3_staging_manager" {
  name = "example-s3-staging-manager"
}

resource "aws_iam_access_key" "example_s3_staging_manager" {
  user = "${aws_iam_user.example_s3_staging_manager.name}"
}

data "template_file" "example_s3_staging_manager_policy" {
  template = "${file("iam-policies/example-s3-manager-policy.json")}"

  vars {
    S3_BUCKET_ARN = "${aws_s3_bucket.example_staging.arn}"
  }
}

resource "aws_iam_user_policy" "example_s3_staging_manager_policy" {
  name   = "example-s3-staging-manager-policy"
  user   = "${aws_iam_user.example_s3_staging_manager.name}"
  policy = "${data.template_file.example_s3_staging_manager_policy.rendered}"
}
