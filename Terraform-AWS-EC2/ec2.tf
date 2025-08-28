module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = aws_subnet.my_subnet.id
  security_group_id = aws_security_group.ssh_sg.id
  instance_count    = 1 # Change this number as needed
  user_data         = file("${path.module}/files/nginx.sh")
}