module "ebs_csi_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name             = "${var.cluster_name}-ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws" # Replace with the actual source path
  version = "~> 20.0" # Replace with the actual version that supports the argument

  cluster_name    = var.cluster_name
  cluster_version = "1.30" # Specify the desired Kubernetes version
  subnet_ids               = var.subnet_ids
  vpc_id          = var.vpc_id # The VPC ID where the cluster and subnets are located
  cluster_endpoint_public_access  = true


  # Enable cluster logging
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_addons = {
    aws-ebs-csi-driver = {
      service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
      most_recent = true
    }
  }

  access_entries = {
    # One access entry with a policy associated
    aws_user = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::975050077248:user/aws_user"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
        admin_cluster = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  }

}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = module.eks.cluster_name
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

