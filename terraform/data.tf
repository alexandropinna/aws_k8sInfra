data "aws_key_pair" "key" {
  key_name = "aws_lex_key"
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.endpoint
}
