# --- Global Variables for Tags ---

# Define a map of key-value pairs for tags that can be applied across various resources in the Terraform configuration.
variable "tags" {
  description = "Project tags"
  type        = map(string)
}

# --- Variables for VPC and Subnets ---

# Define a CIDR block for creating a VPC in the Virginia region.
variable "virginia_cidr" {
  description = "CIDR for Virginia"
  type        = string
}

# Define a list of availability zones (AZs) where subnets will be created.
variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

# Define a list of CIDR blocks for creating private subnets within the specified availability zones.
variable "private_subnet" {
  description = "Private subnets"
  type        = list(string)
}

# Define a list of CIDR blocks for creating public subnets within the specified availability zones.
variable "public_subnet" {
  description = "Public subnets"
  type        = list(string)
}

# Define a list of port numbers that will be allowed for inbound traffic in the security group.
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# Define a CIDR block that specifies which IP addresses are allowed to initiate inbound traffic.
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# Define a boolean variable to decide if an Internet Gateway should be created for the VPC.
variable "create_igw" {
  description = "Indicates whether to create an Internet Gateway"
  type        = bool
}

# Define a boolean variable to decide if a NAT Gateway should be provisioned for the VPC.
variable "enable_nat_gateway" {
  description = "Indicates whether to enable a NAT Gateway"
  type        = bool
}

# Define a boolean variable to decide if a single NAT Gateway should be used for all availability zones or multiple NAT Gateways for each availability zone.
variable "single_nat_gateway" {
  description = "Indicates whether to create a single NAT Gateway for all availability zones"
  type        = bool
}
