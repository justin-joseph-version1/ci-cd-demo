resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "my-vpc"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

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


resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.subnet_a_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "public-a"
  }
}


resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.subnet_b_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "public-b"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.subnet_c_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    "Name" = "public-c"
  }
}


resource "aws_route_table_association" "rta-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.my-route.id
}

resource "aws_route_table_association" "rta-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.my-route.id
}

resource "aws_route_table_association" "rta-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.my-route.id
}


