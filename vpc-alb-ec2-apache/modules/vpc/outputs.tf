output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "public_subnet_a_id" {
  value = aws_subnet.public-a.id
}