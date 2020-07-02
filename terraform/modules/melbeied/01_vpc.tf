resource "aws_vpc" "melbeied" {
  cidr_block = "10.0.0.0/22"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"

  tags = {
    Name = "main_vpc"
  }
}