variable "aws_region" {
  type = string
  description = "AWS region for deployment"
}

variable "aws_availability_zone" {
  type = string
  description = "AWS availability for deployment"
}


variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "EC2 instance type"
}


