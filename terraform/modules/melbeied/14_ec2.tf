resource "aws_instance" "bastion" {
 
    ami = var.ami_id
    availability_zone =  element(data.aws_availability_zones.available.names, 0)
    instance_type = var.instance_bastion_type
    key_name = format("%s", var.public_key_name)
    vpc_security_group_ids = [ aws_security_group.public_alb_sg.id, ]
    subnet_id = element(aws_subnet.public.*.id, 0)
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = format("%s-%s","BastionVM", element(data.aws_availability_zones.available.names, 0))
    }
}



resource "aws_instance" "wp" {
    count                       = local.az_limit
    ami                         = var.ami_id
    availability_zone           =  element(data.aws_availability_zones.available.names, count.index)
    instance_type               = var.instance_wp_type
    key_name                    = format("%s", var.public_key_name)
    vpc_security_group_ids      = [ aws_security_group.front_sg.id, ]
    subnet_id                   = element(aws_subnet.front.*.id, count.index)
    associate_public_ip_address = false
    user_data                   = file("${path.module}/../../scripts/user_data_front.sh")

    tags = {
        Name = format("%s-%s","wp_vm", element(data.aws_availability_zones.available.names, 0))
    }
}

resource "aws_alb_target_group_attachment" "alb_bfornt_http" {
  count            = local.az_limit
  target_group_arn = aws_alb_target_group.tg.arn
  target_id        = element(aws_instance.wp.*.id, count.index)
  port             = 80
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
      sys_user                  = local.sys_user
      
    }
  )
  filename = "../ansible/ssh.cfg"
}