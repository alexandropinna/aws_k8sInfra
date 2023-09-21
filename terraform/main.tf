# Import and use the "security_group" module to create security groups.
module "security_group" {
  source = "./modules/security_group" # Location of the security_group module.
  vpc_id = module.vpc.vpc_id          # Reference VPC ID from the VPC module.

  # Pass variables to the security_group module.
  ingress_ports_list = var.ingress_ports_list
  egress_ports_list  = var.egress_ports_list
  sg_ingress_cidr    = var.sg_ingress_cidr
  sg_egress_cidr     = var.sg_egress_cidr
  tags               = var.tags
}

# Import and use the "vpc" module to create VPC and related resources.
module "vpc" {
  source        = "./modules/vpc"   # Location of the vpc module.
  virginia_cidr = var.virginia_cidr # CIDR block for the VPC.

  # Pass variables to the vpc module.
  ingress_ports_list = var.ingress_ports_list
  sg_ingress_cidr    = var.sg_ingress_cidr
  azs                = var.azs
  private_subnet     = var.private_subnet
  public_subnet      = var.public_subnet
  create_igw         = true  # Explicitly enable Internet Gateway creation.
  enable_nat_gateway = true  # Explicitly enable NAT Gateway creation.
  single_nat_gateway = false # Do not use a single NAT Gateway for all AZs.
  tags               = var.tags
}

# Import and use the "eks" module to create an EKS cluster.
module "eks" {
  source       = "./modules/eks"  # Location of the eks module.
  cluster_name = "my_cluster_k8s" # Name of the EKS cluster.

  # Reference subnet IDs from the VPC module for EKS.
  subnet_ids = module.vpc.eks_subnet_ids
  tags       = var.tags
}
