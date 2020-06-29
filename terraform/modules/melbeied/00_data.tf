//data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  az_limit = 2
  site_name = "melbeied.net"
  project_name = "wamp"
}
resource "aws_eip" "nat_eip" {
  vpc = true
}

// # Gathers information about the VPC that was provided
// # such that we can know what CIDR block to allow requests
// # from and to the FS.
// data "aws_vpc" "main" {
//   id = aws_vpc.melbeied.id
// }

data "aws_route53_zone" "zone" {
  name         = "${local.site_name}."
  private_zone = false
}
