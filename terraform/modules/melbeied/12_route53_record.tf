resource "aws_route53_record" "validation" {
  name    = format("wamp.%s", var.domain_name)
  type    = "A"
  zone_id = var.hosted_zone_id
  allow_overwrite = true
  alias {
    name                   = aws_cloudfront_distribution.wordpress_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.wordpress_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}