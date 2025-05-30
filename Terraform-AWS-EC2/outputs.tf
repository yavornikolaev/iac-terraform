output "ec2_private_ips" {
  description = "Private IPs of EC2 instances"
  value       = module.ec2.myec2_private_ips
}

output "ec2_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = module.ec2.myec2_public_ips
}