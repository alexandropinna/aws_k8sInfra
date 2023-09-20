variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "k8s_v1"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "List of enabled cluster log types."
  type        = list(string)
  default     = ["api", "audit"]
}

variable "retention_in_days" {
  description = "Retention period for CloudWatch logs."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Project tags"
  type        = map(string)
}