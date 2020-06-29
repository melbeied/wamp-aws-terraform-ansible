variable "ami_id" {
  default = "ami-bfff49c2"
}
// region = eu-west-3 : 
// source https://wiki.centos.org/Cloud/AWS
// https://aws.amazon.com/marketplace/pp/Centosorg-CentOS-7-x8664-with-Updates-HVM/B00O7WM7QW#pdp-pricing

variable "instance_bastion_type" {
  default   = "t2.micro"
  #default   = "t2.medium"
}

variable "instance_wp_type" {
  #default   = "t2.micro"
  default   = "t2.medium"
}

variable "public_key_name" {
  default   = "terraform_ec2_key"
}

variable "public_key_path" {
  default   = "/workspace/vagrant/aws/workspace/keys"
}