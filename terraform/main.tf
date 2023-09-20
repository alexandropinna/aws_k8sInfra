module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

  ingress_ports_list = var.ingress_ports_list
  egress_ports_list = var.egress_ports_list

  sg_ingress_cidr = var.sg_ingress_cidr
  sg_egress_cidr = var.sg_egress_cidr 
  
  tags = var.tags
}

module "vpc" {
  source = "./modules/vpc"
  virginia_cidr = var.virginia_cidr

  ingress_ports_list = var.ingress_ports_list
  sg_ingress_cidr = var.sg_ingress_cidr

  azs  = var.azs

  private_subnet = var.private_subnet
  public_subnet  = var.public_subnet

  create_igw = true 
  enable_nat_gateway = true
  single_nat_gateway = false

  tags = var.tags
}

module "eks" {
  source = "./modules/eks"
  cluster_name = "my_cluster_k8s"
  subnet_ids = module.vpc.eks_subnet_ids
  tags = var.tags
}
