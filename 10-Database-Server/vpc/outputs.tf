output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.limtruong_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "linux_sg_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.linux_sg.id
}

output "windows_sg_id" {
  description = "ID of the Windows security group"
  value       = aws_security_group.windows_sg.id
}
