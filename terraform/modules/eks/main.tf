resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_service_policy_attachment
  ]

  enabled_cluster_log_types = []

  tags = {
    Name = "eks-${local.sufix}"
  }
}

resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/eks/${var.cluster_name}/eks_logs"
  retention_in_days = var.retention_in_days
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "default-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn 
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_service_policy_attachment,
    aws_iam_role_policy_attachment.eks_node_bootstrap,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only
  ]
}
