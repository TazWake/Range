provider "aws" {
  region = "eu-west-2"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

# Create a subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "main_subnet"
  }
}

# Create a security group
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.184.137.10/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# EC2 Instance 1 - kali
resource "aws_instance" "kali" {
  ami             = "ami-0f398bcc12f72f967"
  instance_type   = "t2.medium"
  key_name        = "rangeadmin"
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_ssh.name]

  root_block_device {
    volume_size = 12
    volume_type = "gp2"
  }

  tags = {
    Name = "kali"
  }
}

# EC2 Instance 2 - RESEARCH_WKSTN_1
resource "aws_instance" "research_wkstn_1" {
  ami             = "ami-07d1e0a32156d0d21"
  instance_type   = "t2.micro"
  key_name        = "rangeadmin"
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_ssh.name]

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "RESEARCH_WKSTN_1"
  }
}

# EC2 Instance 3 - DFIR
resource "aws_instance" "dfir" {
  ami             = "ami-053a617c6207ecc7b"
  instance_type   = "t2.micro"
  key_name        = "rangeadmin"
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_ssh.name]

  root_block_device {
    volume_size = 25
    volume_type = "gp2"
  }

  tags = {
    Name = "DFIR"
  }
}

# Enable all internal communication within the VPC
resource "aws_security_group_rule" "allow_internal" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_internal_udp" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "udp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.allow_ssh.id
}
