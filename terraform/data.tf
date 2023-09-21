# Retrieve details of the specified AWS Key Pair.
data "aws_key_pair" "key" {
  key_name = "aws_lex_key" # Name of the AWS Key Pair.
}

# Retrieve the authentication token for the specified EKS cluster.
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.endpoint # Endpoint of the EKS cluster defined in the EKS module.
}
