# Create an EKS cluster.
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  # Define the VPC configuration for the EKS cluster.
  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure necessary IAM role policy attachments are created before the EKS cluster.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_service_policy_attachment
  ]

  # Specify the EKS cluster log types to enable.
  # An empty list means no logs are enabled.
  enabled_cluster_log_types = []

  # Add tags to the EKS cluster for better resource identification.
  tags = {
    Name = "eks-${local.sufix}"
  }
}

# Create a CloudWatch Log Group for storing EKS logs.
resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/eks/${var.cluster_name}/eks_logs"
  retention_in_days = var.retention_in_days # Define log retention policy.
}

# Create a default EKS node group associated with the EKS cluster.
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "default-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  # Define the scaling configuration for the EKS node group.
  scaling_config {
    desired_size = 2 # Desired number of worker nodes.
    max_size     = 3 # Maximum number of worker nodes.
    min_size     = 1 # Minimum number of worker nodes.
  }

  # Ensure necessary IAM role policy attachments and other dependencies 
  # are created before the EKS node group.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_service_policy_attachment,
    aws_iam_role_policy_attachment.eks_node_bootstrap,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only
  ]
}
