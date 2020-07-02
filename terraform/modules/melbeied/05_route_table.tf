# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igt.id
  }

  vpc_id = aws_vpc.melbeied.id

  tags  = {
    Name = "public_rt"
  }
}



// Route table : for front subnet

resource "aws_route_table" "front_rt" {
  vpc_id = aws_vpc.melbeied.id
  
  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id        = aws_nat_gateway.nat.id
  }
  
  tags = {
    Name = "front_rt"
  }
}



resource "aws_route_table" "back_rt" {
  vpc_id = aws_vpc.melbeied.id

  route {
    cidr_block        = "0.0.0.0/0"
    nat_gateway_id    = aws_nat_gateway.nat.id
  }
  
  tags = {
    Name = "back_rt"
  }
}
