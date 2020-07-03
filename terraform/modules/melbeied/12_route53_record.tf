resource "aws_route53_record" "validation" {
  name    = local.site_name
  type    = "A"
  zone_id = data.aws_route53_zone.zone.zone_id
  allow_overwrite = true
  alias {
    name                   = aws_cloudfront_distribution.wordpress_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.wordpress_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
  #records = [aws_acm_certificate.default.domain_validation_options.0.resource_record_value]
  #ttl     = 60
}

// resource "aws_route53_record" "validation" {
//   name    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_name}"
//   type    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_type}"
//   zone_id = "${data.aws_route53_zone.external.zone_id}"
//   records = ["${aws_acm_certificate.default.domain_validation_options.0.resource_record_value}"]
//   ttl     = "60"
// }

// resource "aws_route53_record" "root" {
//   zone_id = "${var.zone_id}"
//   name            = "${var.domain}"
//   type            = "A"
//   allow_overwrite = true

//   alias {
//     name                   = "${aws_cloudfront_distribution.wordpress_cloudfront.domain_name}"
//     zone_id                = "${aws_cloudfront_distribution.wordpress_cloudfront.hosted_zone_id}"
//     evaluate_target_health = false
//   }
// }