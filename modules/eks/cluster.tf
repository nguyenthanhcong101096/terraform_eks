resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn

  vpc_config {
    security_group_ids      = [var.cluster_security_group]
    subnet_ids              = var.subnets
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [var.eks_depends]

  tags = {
    Environment = var.env
  }
}
