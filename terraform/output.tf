output "bastion-public-ip" {
  value = "${module.melbeied.bastion-public-ip}"
}

output "rds_address" {
  value = "${module.melbeied.rds_address}"
}

output "cf_wp_hosted_zone-id" {
  value = "${module.melbeied.cf_wp_hosted_zone-id}"
}
output "hosted-zone-console" {
  value = var.hosted_zone_id
}