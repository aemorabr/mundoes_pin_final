resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  instance_types = var.instance_types

    remote_access {
    ec2_ssh_key = var.ssh_key_name
  }
}

