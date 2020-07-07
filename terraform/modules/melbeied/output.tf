output "rds_endpoint" {
  value = "${aws_db_instance.default.endpoint}"
}

output "rds_address" {
  value = "${aws_db_instance.default.address}"
}

output "rds_port" {
  value = "${aws_db_instance.default.port}"
}

output "bastion-public-ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "cf_wp_hosted_zone-id" {
  value = "${aws_cloudfront_distribution.wordpress_cloudfront.hosted_zone_id}"
}