# --- Global Variables for Tags ---

# Define a map of key-value pairs for tags to be applied to all resources in the Terraform configuration.
variable "tags" {
  description = "Project tags"
  type        = map(string)
}

# --- Variables for VPC (Virtual Private Cloud) Configuration ---

# Define a CIDR block for creating a VPC in the Virginia region.
variable "virginia_cidr" {
  description = "Virginia CIDR"
  type        = string
}

# Define a list of availability zones (AZs) where the subnets will be created.
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

# Define a list of port numbers that will be allowed for incoming traffic (ingress) to the security group.
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# Define a CIDR block for specifying which IP addresses are allowed to initiate incoming traffic (ingress) to the VPC.
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# Define a list of port numbers that will be allowed for outgoing traffic (egress) from the security group.
variable "egress_ports_list" {
  description = "List of egress ports"
  type        = list(number)
}

# Define a CIDR block for specifying which IP addresses the VPC resources can communicate with for outgoing traffic (egress).
variable "sg_egress_cidr" {
  description = "CIDR for egress traffic"
  type        = string
}
