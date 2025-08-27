#!/bin/bash
if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [[ "$ID" == "ubuntu" ]]; then
    sudo apt-get update -y
    sudo apt-get install -y nginx
  elif [[ "$ID" == "amzn" ]]; then
    sudo yum update -y
    sudo amazon-linux-extras install nginx1 -y
    sudo yum install -y nginx
  fi
fi

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