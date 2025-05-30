output "myec2_private_ips" {
  value = [for instance in aws_instance.myec2 : instance.private_ip]
}

output "myec2_public_ips" {
  value = [for instance in aws_instance.myec2 : instance.public_ip]
}