
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
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx

              # IMDSv2: Get token first
              TOKEN=$(curl -s --request PUT "http://169.254.169.254/latest/api/token" \
              --header "X-aws-ec2-metadata-token-ttl-seconds: 21600")

              # Get the Public IP with the token
              PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 \
              --header "X-aws-ec2-metadata-token: $TOKEN")
              
              # Write to index.html
              echo "<h1>Deployed with Terraform Module</h1>" | sudo tee /var/www/html/index.html
              echo "<p>Public IP Address: $PUBLIC_IP</p>" | sudo tee -a /var/www/html/index.html
              EOF
              
  tags = {
    Name = "myec2-${count.index + 1}"
  }
}