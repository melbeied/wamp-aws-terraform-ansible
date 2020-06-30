variable "ami_id" {
  default = "ami-0c24eddbea3a65909" // debian buster
}

variable "instance_bastion_type" {
  default   = "t2.micro"
}

variable "instance_wp_type" {
  default   = "t2.medium"
}

variable "public_key_name" {
  default   = "id_rsa_aws"
}

variable "public_key_path" {
  default   = "/workspace/vagrant/aws/workspace/wamp-aws-terraform-ansible/keys"
}