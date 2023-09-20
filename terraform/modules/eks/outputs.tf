output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}


output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
  description = "The name of the EKS cluster"
}


