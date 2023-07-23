########################################
# VPC
########################################
module "vpc" {
  source = "../../../../modules/vpc"

  name = var.name
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
}

########################################
# EKS
########################################
module "eks" {
  source = "../../../../modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  # enable_irsa     = true

  eks_managed_node_groups = var.eks_managed_node_groups

  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_addons                 = var.cluster_addons
}

