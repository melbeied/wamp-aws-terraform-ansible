

resource "aws_instance" "bastion" {
 
    ami = var.ami_id
    availability_zone =  element(data.aws_availability_zones.available.names, 0)
    instance_type = var.instance_bastion_type
    key_name = var.public_key_name
    vpc_security_group_ids = [ aws_security_group.public_alb_sg.id, ]
    subnet_id = element(aws_subnet.public.*.id, 0)
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = format("%s-%s","BastionVM", element(data.aws_availability_zones.available.names, 0))
    }
}



resource "aws_instance" "wp" {
    count               = local.az_limit
    ami                 = var.ami_id
    instance_type       = var.instance_wp_type
    subnet_id           = element(aws_subnet.front.*.id, count.index)
    key_name            = var.public_key_name
    #user_data           = data.template_file.script.rendered
    user_data           = file("${path.module}/../../scripts/install-apache.sh")
    security_groups     = aws_security_group.front_sg.*.id
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/../../templates/hosts.tpl",
    {
      provate_ips       = aws_instance.wp.*.private_ip
      bastion_pub_ip    = aws_instance.bastion.public_ip
      
    }
  )
  filename = "../ansible/hosts"
}
//cidr_partial_wildcards
resource "local_file" "ssh_cfg" {
  content = templatefile("${path.module}/../../templates/ssh.tpl",
    {
      private_key               = format("%s/%s", var.public_key_path, var.public_key_name)  
      cidr_partial_wildcards    = format("%s.%s.*", split (".", aws_vpc.melbeied.cidr_block)[0],split (".", aws_vpc.melbeied.cidr_block)[1])
      bastion_pub_ip            = aws_instance.bastion.public_ip
      
    }
  )
  filename = "../ansible/ssh.cfg"
}

//#ssh -o ProxyCommand="ssh -W %h:%p ntc@bastion" ntc@csr1