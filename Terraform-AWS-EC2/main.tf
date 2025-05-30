terraform {
  required_version = "~> 1.11" # Allows Terraform 1.11.x

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Allows AWS provider 5.x.x
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.my_subnet.id
  security_group_id = aws_security_group.ssh_sg.id
  instance_count = 2 # Change this number as needed
}