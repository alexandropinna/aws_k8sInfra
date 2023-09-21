# Define a policy document to allow EKS service to assume a role.
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# Define a policy document to allow EC2 instances (EKS nodes) to assume a role.
data "aws_iam_policy_document" "eks_nodes_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create an IAM role for EKS nodes.
resource "aws_iam_role" "eks_node_role" {
  name               = "${var.cluster_name}-node"
  assume_role_policy = data.aws_iam_policy_document.eks_nodes_assume_role.json
}

# Attach the AmazonEC2ContainerRegistryReadOnly policy to the EKS node role.
# This allows nodes to pull images from Amazon ECR.
resource "aws_iam_role_policy_attachment" "eks_ecr_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

# Create an IAM role for the EKS cluster.
resource "aws_iam_role" "eks_role" {
  name               = var.cluster_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach the AmazonEKSClusterPolicy to the EKS cluster role.
# This policy grants permissions required for EKS cluster management.
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

# Attach the AmazonEKSServicePolicy to the EKS cluster role.
# This policy grants permissions required for the EKS service.
resource "aws_iam_role_policy_attachment" "eks_service_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_role.name
}

# Attach the AmazonEKSWorkerNodePolicy to the EKS node role.
# This policy grants permissions required for EKS nodes.
resource "aws_iam_role_policy_attachment" "eks_node_bootstrap" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

# Attach the AmazonEKS_CNI_Policy to the EKS node role.
# This policy grants permissions required for the EKS CNI plugin.
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}
