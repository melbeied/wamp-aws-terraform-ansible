
# resource "aws_acm_certificate_validation" "default" {
#   certificate_arn         = var.cert_arn
#   //certificate_arn         = aws_acm_certificate.cert.arn
#   //validation_record_fqdns = [ aws_route53_record.validation.fqdn]
#   validation_record_fqdns = [ aws_acm_certificate.cert.domain_validation_options.0.resource_record_name, ]
# }