//data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  az_limit      = 2
  project_name  = "wamp"
  sys_user      = "admin"
}
resource "aws_eip" "nat_eip" {
  vpc           = true
}

// # Gathers information about the VPC that was provided
// # such that we can know what CIDR block to allow requests
// # from and to the FS.
// data "aws_vpc" "main" {
//   id = aws_vpc.melbeied.id
// }
# DNS account


data "aws_route53_zone" "zone" {
  name = format("%s.", var.domain_name) # Notice the dot!!!
  private_zone = false
}