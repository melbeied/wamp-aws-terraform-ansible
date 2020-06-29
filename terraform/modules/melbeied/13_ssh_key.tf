


resource "aws_key_pair" "terraform_ec2_key" {
    key_name = var.public_key_name
    #public_key = "${file("/workspace/vagrant/aws/workspace/keys/terraform_ec2_key.pub")}"
    public_key = file(format("%s/%s.pub", var.public_key_path, var.public_key_name))
}