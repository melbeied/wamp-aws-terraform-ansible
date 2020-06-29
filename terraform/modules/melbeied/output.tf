output "rds_endpoint" {
  value = "${aws_db_instance.default.endpoint}"
}

output "rds_adress" {
  value = "${aws_db_instance.default.adress}"
}

output "rds_port" {
  value = "${aws_db_instance.default.port}"
}