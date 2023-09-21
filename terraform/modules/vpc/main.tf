# --- VPC (Virtual Private Cloud) ---

# Create a VPC in Virginia.
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

# Create multiple private subnets in the VPC based on the provided list.
resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnet)
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.private_subnet[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "eks_private_subnet-${local.sufix}"
  }
}

# Create multiple public subnets in the VPC based on the provided list.
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet)
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "eks_public_subnet-${local.sufix}"
  }
}

# --- Internet Gateway ---

# Conditionally create an Internet Gateway and associate it with the VPC.
resource "aws_internet_gateway" "igw" {
  count  = var.create_igw ? 1 : 0 # Create IGW only if 'create_igw' variable is true.
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "igw_vpc_virginia-${local.sufix}"
  }
}

# --- Route Tables ---

# Create a public route table for the VPC with a default route to the Internet Gateway.
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id
  route {
    cidr_block = "0.0.0.0/0"
    # Use the created IGW if 'create_igw' variable is true, else set it to null.
    gateway_id = var.create_igw ? aws_internet_gateway.igw[0].id : null
  }
  tags = {
    Name = "public crt-${local.sufix}"
  }
}

# Associate the public route table with all the created subnets (both public and private).
resource "aws_route_table_association" "crta_eks_subnets" {
  count = length(var.private_subnet) + length(var.public_subnet)

  subnet_id = element(
    concat(aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id),
    count.index
  )
  route_table_id = aws_route_table.public_crt.id
}
