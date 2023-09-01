terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  #backend "s3" {
  #  bucket = "justinjoeman-test-bucket"
  #  key    = "mystatefile"
  #  region = "us-east-1"
  #  access_key = ""
  #  secret_key = ""
  #}
}

module "vpc" {
  source = "./modules/vpc"
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

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

  ingress {
    description = "SSH Traffic"
    from_port   = 22
    to_port     = 22
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

# EC2 webservers

resource "aws_instance" "server-a" {
  instance_type     = "t2.medium"
  availability_zone = "us-east-1a"
  ami               = "ami-053b0d53c279acc90"
  subnet_id = module.vpc.private_subnet_a_id
  key_name          = "demo-key"
  user_data = <<-EOF
                  #!/bin/bash
                  sudo apt -y update
                  sudo apt -y install apache2
                  sudo ufw allow 'Apache'
                  sudo systemctl start apache2
                  bash -c 'echo I AM BATMAN! > /var/www/html/index.html'
                  EOF

  tags = {
    "private-server" = "false"
    "Name"           = "server-a"
  }
}


resource "aws_instance" "server-b" {
  instance_type     = "t2.medium"
  availability_zone = "us-east-1b"
  ami               = "ami-053b0d53c279acc90"
  subnet_id = module.vpc.private_subnet_b_id
  key_name          = "demo-key"
  user_data = <<-EOF
                  #!/bin/bash
                  sudo apt -y update
                  sudo apt -y install apache2
                  sudo ufw allow 'Apache'
                  sudo systemctl start apache2
                  bash -c 'echo I AM SUPERMAN! > /var/www/html/index.html'
                  EOF

  tags = {
    "private-server" = "false"
    "Name"           = "server-b"
  }
}

resource "aws_instance" "server-c" {
  instance_type     = "t2.medium"
  availability_zone = "us-east-1c"
  ami               = "ami-053b0d53c279acc90"
  subnet_id = module.vpc.private_subnet_c_id
  key_name          = "demo-key"
  user_data = <<-EOF
                  #!/bin/bash
                  sudo apt -y update
                  sudo apt -y install apache2
                  sudo ufw allow 'Apache'
                  sudo systemctl start apache2
                  bash -c 'echo I AM WONDER WOMAN! > /var/www/html/index.html'
                  EOF

  tags = {
    "private-server" = "false"
    "Name"           = "server-c"
  }
}

# ALB

resource "aws_lb" "webserver-alb" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-server-sg.id]
  subnets            = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id, module.vpc.public_subnet_c_id]

  enable_deletion_protection = false

  tags = {
    Environment = "demo"
  }
}

# Target group

resource "aws_lb_target_group" "web-servers" {
  name        = "web-server-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"
}

# Listener

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.webserver-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-servers.arn
  }
}

# instance attachments

resource "aws_lb_target_group_attachment" "web-server-01" {
  target_group_arn = aws_lb_target_group.web-servers.arn
  target_id        = aws_instance.server-a.id
  port             = 80
  depends_on = [
    aws_instance.server-a,
    aws_lb.webserver-alb,
    aws_lb_target_group.web-servers
  ]
}

resource "aws_lb_target_group_attachment" "web-server-02" {
  target_group_arn = aws_lb_target_group.web-servers.arn
  target_id        = aws_instance.server-b.id
  port             = 80
  depends_on = [
    aws_instance.server-b,
    aws_lb.webserver-alb,
    aws_lb_target_group.web-servers
  ]
}

resource "aws_lb_target_group_attachment" "web-server-03" {
  target_group_arn = aws_lb_target_group.web-servers.arn
  target_id        = aws_instance.server-c.id
  port             = 80
  depends_on = [
    aws_instance.server-c,
    aws_lb.webserver-alb,
    aws_lb_target_group.web-servers
  ]
}

