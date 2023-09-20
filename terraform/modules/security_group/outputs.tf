# ID of the security group for public instances
output "sg_public_instance_id" {
  value       = aws_security_group.sg_public_instance.id
  description = "The ID of the security group for public instances"
}
