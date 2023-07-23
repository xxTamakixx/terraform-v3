########################################
# EKS
########################################
output "cluster_id" {
  value       = module.eks.cluster_id
  description = "cluster_id"
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.eks.cluster_endpoint
}