# Define a variable for the EKS cluster's name.
variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "k8s_v1"
}

# Define a variable for the subnet IDs where the EKS cluster will be deployed.
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}

# Define a variable for the types of logs to be enabled on the EKS cluster.
variable "enabled_cluster_log_types" {
  description = "List of enabled cluster log types."
  type        = list(string)
  default     = ["api", "audit"]
}

# Define a variable for the retention period of the CloudWatch logs.
variable "retention_in_days" {
  description = "Retention period for CloudWatch logs."
  type        = number
  default     = 7
}

# Define a variable for adding tags to the project's resources.
variable "tags" {
  description = "Project tags"
  type        = map(string)
}
