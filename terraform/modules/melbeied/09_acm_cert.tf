# resource "aws_acm_certificate" "default" {
#   domain_name               = var.domain_name
#   validation_method = "DNS"
#   subject_alternative_names = []
#   tags = {
#     Name = "TerraformGeneratedCert"
#   }
# }



# resource "aws_acm_certificate_validation" "default" {
#    certificate_arn         = var.cert_arn
#    //certificate_arn         = aws_acm_certificate.default.arn
#    validation_record_fqdns = ["${aws_route53_record.validation.fqdn}"]
# }