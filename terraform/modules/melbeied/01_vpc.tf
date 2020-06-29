resource "aws_vpc" "melbeied" {
  cidr_block = "10.0.0.0/22"

  tags = {
    Name = "main_vpc"
  }
}