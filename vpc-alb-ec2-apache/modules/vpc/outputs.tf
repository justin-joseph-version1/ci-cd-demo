output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.my-igw.id
}

output "subnet_a_id" {
  value = aws_subnet.public-a.id
}

output "subnet_b_id" {
  value = aws_subnet.public-b.id
}

output "subnet_c_id" {
  value = aws_subnet.public-c.id
}

