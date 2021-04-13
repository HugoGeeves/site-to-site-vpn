output "vpc_id" {
  value       = aws_vpc.network_vpc.id
  description = "The id of the vpc"
}

output "public_subnet_id" {
  value       = aws_subnet.network_public_subnet.id
  description = "The id of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.network_private_subnet.id
  description = "The id of the private subnet"
}