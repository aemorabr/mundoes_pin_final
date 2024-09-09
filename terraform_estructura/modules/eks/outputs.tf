
output "cluster_oidc_issuer_url" {
  value =module.eks.oidc_provider_arn
}
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}
