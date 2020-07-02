
resource "aws_security_group" "public_alb_sg" {
  name        = "SG_public_22_80_443"
  description = "Port 22, 80, 443 from all world"
  vpc_id      = aws_vpc.melbeied.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    description = "worldwide"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    description = "worldwide"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    description = "worldwide"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = -1
    to_port   = -1
    protocol = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "public_sg_for_22_80_443_flow"
  }
}


resource "aws_security_group" "front_sg" {
  name        = "SG_front_80_443"
  description = "Port 22, 80, 443 from vpc subnet"
  vpc_id      = aws_vpc.melbeied.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    description = "flow to enable SSH requests"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
    //security_groups = [ "${aws_security_group.public_alb_sg.id}", ]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    description = "flow to enable HTTP requests"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
    //security_groups = [ "${aws_security_group.public_alb_sg.id}", ]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    description = "flow to enable TLS requests"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
    //security_groups = [ "${aws_security_group.public_alb_sg.id}", ]
  }
  ingress {
    from_port = -1
    to_port   = -1
    protocol = "ICMP"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0", ]
  }
  tags = {
    Name        = "private_front_sg_for_22_80_443_flow"
  }
}

resource "aws_security_group" "back_sg" {
  name        = "SG_back_80_443"
  description = "Port 22, 3306 from vpc subnet"
  vpc_id      = aws_vpc.melbeied.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    description = "flow to enable SSH access"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    description = "flow to enable JDBC access"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
  }

  ingress {
    from_port   = 11211
    to_port     = 11211
    protocol    = "TCP"
    description = "flow to enable MEMCACHED access"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol = "ICMP"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
  }
  tags = {
    Name        = "SG_back_22_3306"
  }
}


// resource "aws_security_group" "efs_sg" {
//   name        = "efs-mnt"
//   description = "Allows NFS traffic from instances within the VPC."
//   vpc_id      = aws_vpc.melbeied.id

//   ingress {
//     from_port = 2049
//     to_port   = 2049
//     protocol  = "tcp"

//     cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
//   }
//   egress {
//     from_port = 0
//     to_port   = 0
//     protocol  = "-1"

//     cidr_blocks = [ aws_vpc.melbeied.cidr_block, ]
//   }
//   tags = {
//     Name = "allow_nfs-ec2"
//   }
// }