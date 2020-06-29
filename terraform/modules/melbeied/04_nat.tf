resource "aws_nat_gateway" "nat" {
  count = "${local.az_limit}"-1
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element("${aws_subnet.public.*.id}", count.index)
  tags = {
      Name = format("%s%s","Nat_az_", split("-",element(data.aws_availability_zones.available.names, count.index))[2])
  }
}