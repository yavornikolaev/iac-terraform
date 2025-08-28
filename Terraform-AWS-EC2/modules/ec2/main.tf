# Fetch latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


resource "aws_instance" "myec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count         = var.instance_count
  key_name    = "yavor-ec2"  
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
  }
  
  
  # Attach the Security Group to the EC2 instance
  vpc_security_group_ids = [var.security_group_id]
  user_data = var.user_data
  subnet_id = var.subnet_id

  tags = {
    Name = "myec2-${count.index + 1}"
  }
}