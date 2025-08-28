variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "EC2 instance type"
}

variable "user_data" { 
  description = "User data script to initialize the instance"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 1
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  description = "The Security Group ID to associate with the instance"
  type        = string
}