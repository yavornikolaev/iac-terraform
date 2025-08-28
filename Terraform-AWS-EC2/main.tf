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