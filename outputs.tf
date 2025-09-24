output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private IP of the bastion host"
  value       = aws_instance.bastion.private_ip
}

output "private_instance_ip" {
  description = "Private IP of the private instance"
  value       = aws_instance.private.private_ip
}

output "nat_gateway_ip" {
  description = "Public IP of the NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}

output "ssh_command_bastion" {
  description = "SSH command to connect to bastion host"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${aws_instance.bastion.public_ip}"
}

output "ssh_command_private" {
  description = "SSH command to connect to private instance via bastion"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem -o ProxyCommand='ssh -i ~/.ssh/${var.key_pair_name}.pem -W %h:%p ec2-user@${aws_instance.bastion.public_ip}' ec2-user@${aws_instance.private.private_ip}"
}