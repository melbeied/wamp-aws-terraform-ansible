output "bastion-public-ip" {
  value = "${module.melbeied.bastion-public-ip}"
}

output "rds_address" {
  value = "${module.melbeied.rds_address}"
}