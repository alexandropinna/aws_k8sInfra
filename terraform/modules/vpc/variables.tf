# --- Global Variables for Tags ---

# General tags for all the resources in the project
variable "tags" {
  description = "Project tags"
  type        = map(string)
}

# --- Variables for VPC and Subnets ---

# CIDR block for the VPC in the Virginia region
variable "virginia_cidr" {
  description = "CIDR for Virginia"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "private_subnet" {
  description = "Private subnets"
  type        = list(string)
}

variable "public_subnet" {
  description = "Public subnets"
  type        = list(string)
}

# List of ports that will be allowed in the security group's inbound rules
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# CIDR block that will be allowed in the security group's inbound rules
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "create_igw" {
  description = "Indicates whether to create an Internet Gateway"
  type        = bool
}

variable "enable_nat_gateway" {
  description = "Indicates whether to enable a NAT Gateway"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Indicates whether to create a single NAT Gateway for all availability zones"
  type        = bool
}
