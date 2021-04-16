output "public_ip" {
  description = "The public ip of the instance if it should exist"
  value       = aws_instance.instance.public_ip
}