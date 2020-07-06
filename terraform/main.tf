module "melbeied" {
        source                  = "./modules/melbeied"
        /////////////////////////////////////////////////////
        ami_id                  =   var.ami_id
        instance_bastion_type   =   var.instance_bastion_type
        instance_wp_type        =   var.instance_wp_type
        public_key_name         =   var.public_key_name
        public_key_path         =   var.public_key_path
        cert_arn                =   var.cert_arn

        db_instance_type        = var.db_instance_type
        db_name                 = var.db_name
        db_user                 = var.db_user
        db_password             = var.db_password
        domain_name             = var.domain_name
        site_name               = var.site_name
        hosted_zone_id          = var.hosted_zone_id
}