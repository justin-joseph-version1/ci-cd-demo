# SG 
resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    Name = "web-server-sg"
  }
}

# EC2 instances
resource "aws_instance" "server-a" {
  count             = 3
  instance_type     = "t2.medium"
  availability_zone = "us-east-1a"
  ami               = "ami-051f7e7f6c2f40dc1"
  subnet_id         = module.vpc.public_subnet_a_id
  security_groups   = ["${aws_security_group.web-server-sg.id}"]
  key_name          = "demo-key"
}
