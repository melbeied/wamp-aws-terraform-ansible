# Route table : association with public subnets
resource "aws_route_table_association" "public_ass" {
  count                     = length(aws_subnet.public.*.id)
  subnet_id                 = element(aws_subnet.public.*.id, count.index)
  route_table_id            = aws_route_table.public_rt.id
}

# Route table : association with PRIVATE SUBNET : front 1st & 2nd subnet
resource "aws_route_table_association" "front_ass" {
  count           = length(aws_subnet.front.*.id)
  subnet_id       = element(aws_subnet.front.*.id, count.index)
  route_table_id  = aws_route_table.front_rt.id
}