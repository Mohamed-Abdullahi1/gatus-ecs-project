output "vpc_id" {
  value = aws_vpc.gatus_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

output "igw_id" {
  value = aws_internet_gateway.gatus_gw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.gatus_nat.id
}