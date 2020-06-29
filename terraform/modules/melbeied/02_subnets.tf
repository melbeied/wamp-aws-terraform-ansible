resource "aws_subnet" "public" {
  count                     = local.az_limit
  vpc_id                    = aws_vpc.melbeied.id
  cidr_block                = "10.0.${count.index}.0/27"
  availability_zone         = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch   = true

  tags  = {
    Name = format("%s%s","sn_public_", split("-", element(data.aws_availability_zones.available.names, count.index))[2])
  }
}


resource "aws_subnet" "front" {
  count                     = local.az_limit
  vpc_id                    = aws_vpc.melbeied.id
  cidr_block                = "10.0.${count.index}.32/27"
  availability_zone         = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch   = false

  tags  = {
    Name    = format("%s%s","sn_front_",split("-", element(data.aws_availability_zones.available.names, count.index))[2])
  }
}


resource "aws_subnet" "back" {
  count                     = local.az_limit
  vpc_id                    = aws_vpc.melbeied.id
  cidr_block                = "10.0.${count.index}.64/27"
  availability_zone         = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch   = false

  tags  = {
    Name    = format("%s%s","sn_back_",split("-", element(data.aws_availability_zones.available.names, count.index))[2])
  }
}