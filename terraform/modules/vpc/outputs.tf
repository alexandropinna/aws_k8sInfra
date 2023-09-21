# --- Outputs for VPC and Subnets ---

# ID of the public subnet
output "eks_subnet_ids" {
  value       = concat(aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id)
  description = "The IDs of the subnets in the VPC"
}

# ID of the VPC
output "vpc_id" {
  value       = aws_vpc.vpc_virginia.id
  description = "The ID of the VPC where the resources are created"
}
