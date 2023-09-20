# --- Global variables for tags ---

# General tags for all project resources
variable "tags" {
  description = "Project tags"
  type        = map(string)
}

# --- Variables for the VPC (Virtual Private Cloud) ---

# CIDR of the VPC in the Virginia region
variable "virginia_cidr" {
  description = "Virginia CIDR"
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

# List of ports for incoming traffic rules (ingress)
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# CIDR for incoming traffic (ingress) to the VPC
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "egress_ports_list" {
  description = "List of egress ports"
  type        = list(number)
}

variable "sg_egress_cidr" {
  description = "CIDR for egress traffic"
  type        = string
}
