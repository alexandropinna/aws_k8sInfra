# Terraform Configuration Block
# Sets the requirements for providers and the Terraform version.
terraform {
  # Required providers and their versions
  required_providers {
    # AWS provider with a minimum version of 5.12.0
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.12.0"
    }

    # Random provider with a specific version of 3.5.1
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  # Required version of Terraform, compatible with version 1.5.0
  required_version = "~>1.5.0"
}

# AWS Provider Configuration
provider "aws" {
  # Region where the resources will be deployed
  region = "us-east-1"

  # Default tags for all created resources
  default_tags {
    tags = var.tags
  }
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}