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


// data "aws_route53_zone" "zone" {
//   name = format("%s.", var.domain_name) # Notice the dot!!!
//   private_zone = false
// }