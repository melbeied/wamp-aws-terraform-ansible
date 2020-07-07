resource "aws_cloudfront_distribution" "wordpress_cloudfront" {
  origin {
    domain_name = aws_alb.alb.dns_name
    origin_id   = "wordpress_cloudfront"

    custom_origin_config {
      origin_protocol_policy = "http-only"
      https_port             = 443
      http_port              = 80
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
  http_version = "http1.1"
  enabled = true
  aliases = [ var.site_name, "www.${var.domain_name}" ]

  default_cache_behavior {
    target_origin_id = "wordpress_cloudfront"
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["HEAD", "GET"]
    compress         = true

    forwarded_values {
      query_string = false
      headers      = ["Host"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "${local.project_name}-cloudfront"
  }

  viewer_certificate {
    ///acm_certificate_arn     = aws_acm_certificate.cert.arn
    acm_certificate_arn      = var.cert_arn
    //acm_certificate_arn      = aws_acm_certificate.default.arn
    ssl_support_method       = "sni-only"
    cloudfront_default_certificate = true
    minimum_protocol_version = "TLSv1"
  }
}


// resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
//   comment = "cloudfront origin access identity"
// }

// resource "aws_cloudfront_distribution" "site_cdn" {
//   enabled      = true
//   price_class  = "PriceClass_200"
//   http_version = "http1.1"
//   aliases = [ local.site_name, ]
//   depends_on = [ aws_acm_certificate_validation.cert, ]
  
//   origin {
//     origin_id   = "origin-bucket-${aws_s3_bucket.www_site.id}"
//     domain_name = "www.${local.site_name}.s3.us-east-1.amazonaws.com"

//     s3_origin_config {
//       origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
//     }
//   }

//   default_root_object = "index.html"

//   default_cache_behavior {
//     allowed_methods = ["GET", "HEAD"]
//     cached_methods  = ["GET", "HEAD"]
//     target_origin_id = "origin-bucket-${aws_s3_bucket.www_site.id}"

//     min_ttl          = "0"
//     default_ttl      = "300"                                              //3600
//     max_ttl          = "1200"                                             //86400

//     // This redirects any HTTP request to HTTPS. Security first!
//     viewer_protocol_policy = "redirect-to-https"
//     compress               = true

//     forwarded_values {
//       query_string = false

//       cookies {
//         forward = "none"
//       }
//     }
//   }

//   restrictions {
//     geo_restriction {
//       restriction_type = "none"
//     }
//   }
//   viewer_certificate {
//     acm_certificate_arn      = aws_acm_certificate.cert.arn
//     cloudfront_default_certificate = true
//     ssl_support_method       = "sni-only"
//     minimum_protocol_version = "TLSv1"
//   }
// }

//https://github.com/soroushatarod/terraform-aws-cloudfront-wordpress