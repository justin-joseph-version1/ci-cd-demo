resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "demo-vpc"
  }
}

# IGW 
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}


# Route tables
resource "aws_route_table" "my-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my-internet-traffic"
  }
}


# Public subnets
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public-a"
  }
}

# Public route associations
resource "aws_route_table_association" "rta-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.my-route.id
}