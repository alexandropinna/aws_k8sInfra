# # --- Variables for Public Instances and Security Groups ---

# # List of ports that will be allowed in the ingress rules of the security group
# variable "ingress_ports_list" {
#   description = "List of ingress ports"
#   type        = list(number)
# }

# # CIDR block that will be allowed in the ingress rules of the security group
# variable "sg_ingress_cidr" {
#   description = "CIDR for ingress traffic"
#   type        = string
# }

# # CIDR block that will be allowed in the ingress rules of the RDS security group
# # variable "rds_access_cidr" {
# #   description = "CIDR for RDS"
# #   type        = string
# # }

# # ID of the VPC where instances and security groups will be created
# variable "vpc_id" {
#   description = "ID for the VPC"
#   type        = string
# }

# # CIDR block that will be allowed for SSH traffic
# # By default, all traffic is allowed (0.0.0.0/0)
# variable "ssh_allowed_cidr" {
#   description = "Allowed CIDR block for SSH"
#   type        = string
#   default     = "0.0.0.0/0"
# }

# # --- Global Variables for Tags (tags) ---

# # General tags for all resources in the project
# variable "tags" {
#   description = "Project tags"
#   type        = map(string)
# }


# List of ports that will be allowed in the ingress rules of the security group
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# CIDR block that will be allowed in the ingress rules of the security group
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# List of ports that will be allowed in the egress rules of the security group
variable "egress_ports_list" {
  description = "List of egress ports"
  type        = list(number)
}

# CIDR block that will be allowed in the egress rules of the security group
variable "sg_egress_cidr" {
  description = "CIDR for egress traffic"
  type        = string
}

# ID of the VPC where instances and security groups will be created
variable "vpc_id" {
  description = "ID for the VPC"
  type        = string
}

# CIDR block that will be allowed for SSH traffic
variable "ssh_allowed_cidr" {
  description = "Allowed CIDR block for SSH"
  type        = string
  default     = "0.0.0.0/0"
}

# General tags for all resources in the project
variable "tags" {
  description = "Project tags"
  type        = map(string)
}
