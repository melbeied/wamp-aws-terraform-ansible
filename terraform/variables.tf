variable "domaine_name" {
  default = "melbeied.net"
}
variable "ami_id" {
  default = "ami-0c24eddbea3a65909" // debian buster
}

variable "instance_bastion_type" {
  default   = "t2.medium"
}

variable "instance_wp_type" {
  default   = "t2.large"
}

variable "public_key_name" {
  default   = "id_rsa_aws"
}

variable "public_key_path" {
  default   = "/workspace/vagrant/aws/workspace/wamp-aws-terraform-ansible/keys"
}

variable "db_instance_type" {
  default   = "db.t2.medium"
}

variable "db_name" {
  default = "wordpressdb"
}

variable "db_user" {
  default = "root"
}

variable "db_password" {
}