variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "node_desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
}

variable "node_min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
}

variable "instance_types" {
  description = "List of instance types for the nodes"
  type        = list(string)
  default     = ["t3.small"]
}

variable "ssh_key_name" {
  description = "SSH key name for node group access"
  type        = string
}

variable "role_arn" {
  description = "role_arn for user access"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the vpc where the EC2 instance will be created"
  type        = string
}