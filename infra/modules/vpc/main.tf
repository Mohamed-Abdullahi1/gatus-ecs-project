resource "aws_vpc" "gatus_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "gatus-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.gatus_vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true


  tags = {
    Name = "gatus-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.gatus_vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true


  tags = {
    Name = "gatus-public-b"

  }
}

resource "aws_subnet" "private_a" {

  vpc_id = aws_vpc.gatus_vpc.id

  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false

  tags = {
    Name = "gatus-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.gatus_vpc.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = {
    Name = "gatus-private-b"
  }
}

resource "aws_internet_gateway" "gatus_gw" {
  vpc_id = aws_vpc.gatus_vpc.id

  tags = {
    Name = "gatus_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.gatus_vpc.id

  tags = {
    Name = "gatus-public_rt"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "gatus-nat-eip"
  }
}

resource "aws_nat_gateway" "gatus_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.gatus_gw]

  tags = {
    Name = "gatus_nat"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gatus_gw.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.gatus_vpc.id

  tags = {
    Name = "gatus-private_rt"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gatus_nat.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt.id
}