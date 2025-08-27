
resource "aws_instance" "myec2" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name    = "yavor-ec2"  
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = 9
    volume_type = "gp3"
    delete_on_termination = true
  }
  
  subnet_id = var.subnet_id

  # Attach the Security Group to the EC2 instance
  vpc_security_group_ids = [var.security_group_id]
  
  user_data = var.user_data
  
  tags = {
    Name = "myec2-${count.index + 1}"
  }
}