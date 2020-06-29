


resource "aws_acm_certificate" "cert" {
  domain_name       = local.site_name
  validation_method = "DNS"
}