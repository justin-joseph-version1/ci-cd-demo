resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "demo-vpc"
  }
}

# Network interfaces for NGW
resource "aws_network_interface" "nat-private-a" {
  subnet_id   = aws_subnet.private-a.id
}

resource "aws_network_interface" "nat-private-b" {
  subnet_id   = aws_subnet.private-b.id
}

resource "aws_network_interface" "nat-private-c" {
  subnet_id   = aws_subnet.private-c.id
}


# IGW and NAT Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_nat_gateway" "my-ngw" {
  allocation_id = aws_eip.eip-private-a.id
  subnet_id     = aws_subnet.private-a.id

  tags = {
    Name = "gw NAT-a"
  }

  depends_on = [aws_internet_gateway.my-igw]
}

resource "aws_eip" "eip-private-a" {
  #domain   = "vpc"
  network_interface = aws_network_interface.nat-private-a.id

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

resource "aws_route_table" "my-nat-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-ngw.id
  }

  tags = {
    Name = "my-nat-traffic"
  }
}

# Public subnets
resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "public-a"
  }
}


resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "public-b"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_c_cidr
  availability_zone       = "us-east-1c"

  tags = {
    "Name" = "public-c"
  }
}

# Private subnets
resource "aws_subnet" "private-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "private-a"
  }
}


resource "aws_subnet" "private-b" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "private-b"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private_subnet_c_cidr
  availability_zone       = "us-east-1c"

  tags = {
    "Name" = "private-c"
  }
}


# Public route associations
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


# Private route associations
resource "aws_route_table_association" "rta-private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.my-nat-route.id
}

resource "aws_route_table_association" "rta-private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.my-nat-route.id
}

resource "aws_route_table_association" "rta-private-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.my-nat-route.id
}