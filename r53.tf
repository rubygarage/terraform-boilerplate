resource "aws_route53_zone" "example" {
  name = "google.com"
}

resource "aws_route53_record" "example_com_a" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "google.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.example_nodejs_production.dns_name}"
    zone_id                = "${aws_elb.example_nodejs_production.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api_example_com_a" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "api.google.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.example_rails_production.dns_name}"
    zone_id                = "${aws_elb.example_rails_production.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "txt_example_com_a" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "google.com"
  type    = "TXT"
  ttl     = "300"
  records = ["google-site-verification=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"]
}

resource "aws_route53_record" "www_example_com_a" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "www.google.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["google.com"]
}

resource "aws_route53_record" "staging_example_com_a" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "staging.google.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.example_nodejs_staging.dns_name}"
    zone_id                = "${aws_elb.example_nodejs_staging.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "staging_api_example_com_a" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "staging-api.google.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.example_rails_staging.dns_name}"
    zone_id                = "${aws_elb.example_rails_staging.zone_id}"
    evaluate_target_health = true
  }
}
