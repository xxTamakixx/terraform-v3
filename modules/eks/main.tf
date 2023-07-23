########################################
# EKS
########################################
module "eks" {
  source = "../../resources/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  # enable_irsa     = true

  eks_managed_node_groups = var.eks_managed_node_groups

  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_addons                 = var.cluster_addons

  ## Security group ##
  cluster_security_group_additional_rules = {
    # TCPプロトコルを使用してクラスターのノードから宛先ポート1025から65535の範囲へのアウトバウンド通信を許可します
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {

    admission_webhook = {
      description                   = "Admission Webhook"
      protocol                      = "tcp"
      from_port                     = 0
      to_port                       = 65535
      type                          = "ingress"
      source_cluster_security_group = true
    }

    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

########################################
# ECR
########################################
resource "aws_ecr_repository" "repository" {
  name                 = "black"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

########################################
# OIDC
########################################
resource "aws_iam_policy" "github_actions" {
  name   = "ECRPushPolicy"
  policy = data.aws_iam_policy_document.github_actions.json
}

resource "aws_iam_role" "github_actions" {
  name               = "GitHubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_role_policy_attachment" "github_actions" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions.arn
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]
}