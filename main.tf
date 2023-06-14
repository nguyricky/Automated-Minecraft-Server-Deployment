terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_security_group" "minecraft-security" {
  name        = "minecraft-security"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mc security group"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "mc_key"
  public_key = ""
}

resource "aws_instance" "minecraft" {
  ami                         = "ami-03f65b8614a860c29"
  instance_type               = "t3.medium"
  vpc_security_group_ids      = [aws_security_group.minecraft-security.id]
  key_name                    = aws_key_pair.deployer.key_name
  
  tags = {
    Name = "Minecraft Server"
  }
}

output "instance_id" {
  value       = aws_instance.minecraft.id
}

output "instance_ipv4" {
  value       = aws_instance.minecraft.public_ip
}