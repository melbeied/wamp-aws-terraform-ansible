resource "aws_nat_gateway" "nat" {
  #count = "${local.az_limit}"-1
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element("${aws_subnet.public.*.id}", 0)
  depends_on    = [ aws_internet_gateway.igt ]
  tags = {
      Name = format("%s%s","Nat_az_", split("-",element(data.aws_availability_zones.available.names, 0))[2])
  }
}



// allocation_id = aws_eip.nat.id
//   subnet_id     = aws_subnet.public-subnet.id
//   depends_on    = [aws_internet_gateway.internet-gw]