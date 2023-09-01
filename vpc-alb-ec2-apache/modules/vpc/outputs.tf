output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.my-igw.id
}

output "public_subnet_a_id" {
  value = aws_subnet.public-a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.public-b.id
}

output "public_subnet_c_id" {
  value = aws_subnet.public-c.id
}

output "private_subnet_a_id" {
  value = aws_subnet.private-a.id
}

output "private_subnet_b_id" {
  value = aws_subnet.private-b.id
}

output "private_subnet_c_id" {
  value = aws_subnet.private-c.id
}