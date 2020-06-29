module "melbeied" {
        source                  = "./modules/melbeied"
        /////////////////////////////////////////////////////
        ami_id                  =   var.ami_id
        instance_bastion_type   =   var.instance_bastion_type
        instance_wp_type        =   var.instance_wp_type
        public_key_name         =   var.public_key_name
        public_key_path         =   var.public_key_path
}