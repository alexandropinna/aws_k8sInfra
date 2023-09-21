# Output the endpoint URL of the EKS cluster.
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

# Output the certificate authority data for the EKS cluster.
# This is required for the kubeconfig to authenticate with the cluster.
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

# Output the name of the EKS cluster.
output "cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
  description = "The name of the EKS cluster"
}

# Retrieve authentication token for the EKS cluster.
data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name
}

# Output the authentication token for the EKS cluster.
# This token can be used with the kubeconfig to authenticate to the cluster.
output "token" {
  value = data.aws_eks_cluster_auth.eks_auth.token
}
