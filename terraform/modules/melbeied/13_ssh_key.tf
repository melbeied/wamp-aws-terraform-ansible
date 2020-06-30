resource "aws_key_pair" "id_rsa_aws" {
    key_name = var.public_key_name
    public_key = file(format("%s/%s.pub", var.public_key_path, var.public_key_name))
}