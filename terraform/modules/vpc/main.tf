# --- VPC (Virtual Private Cloud) ---

# Create a VPC in Virginia
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

# --- Subnets ---
# resource "aws_subnet" "eks_subnet_1" {
#   vpc_id                  = aws_vpc.vpc_virginia.id
#   cidr_block              = var.subnets[0]
#   availability_zone = "us-east-1a"
#   tags = {
#     "Name" = "eks_subnet_1-${local.sufix}"
#   }
# }

# resource "aws_subnet" "eks_subnet_2" {
#   vpc_id            = aws_vpc.vpc_virginia.id
#   cidr_block        = var.subnets[1]
#   availability_zone = "us-east-1b"
#   tags = {
#     "Name" = "eks_subnet_2-${local.sufix}"
#   }
# }

# # Create the second subnet for RDS in the VPC
# resource "aws_subnet" "eks_subnet_3" {
#   vpc_id            = aws_vpc.vpc_virginia.id
#   cidr_block        = var.subnets[2]
#   availability_zone = "us-east-1c"
#   tags = {
#     "Name" = "eks_subnet_3-${local.sufix}"
#   }
# }

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet)
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "eks_private_subnet-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet)
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "eks_public_subnet-${local.sufix}"
  }
}

# --- Internet Gateway ---

# Create an Internet Gateway and associate it with the VPC
resource "aws_internet_gateway" "igw" {
  count = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "igw_vpc_virginia-${local.sufix}"
  }
}

# --- Route Tables ---

# Create a public route table for the VPC
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id
  route {
    cidr_block = "0.0.0.0/0"
    # gateway_id = aws_internet_gateway.igw.id
    gateway_id = var.create_igw ? aws_internet_gateway.igw[0].id : null
  }
  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_eks_subnets" {
  count = length(var.private_subnet) + length(var.public_subnet)

  subnet_id      = element(
    concat(aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id),
    count.index
  )
  route_table_id = aws_route_table.public_crt.id
}
