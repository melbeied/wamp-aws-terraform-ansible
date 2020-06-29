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
  tags = {
    Name = "front_rt"
  }
}

resource "aws_route" "worldwid_nat_route" {
  route_table_id         = aws_route_table.front_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, 0)
  
}



// route table : for back subnet


resource "aws_route_table" "back_rt" {
  vpc_id = aws_vpc.melbeied.id
  
  tags = {
    Name = "back_rt"
  }
}


// to activate
resource "aws_route" "nat_route" {
  route_table_id         = aws_route_table.back_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, 0)
}

