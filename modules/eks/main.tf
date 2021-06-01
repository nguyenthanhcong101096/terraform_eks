resource "aws_eks_cluster" "main" {
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
    Environment = "${var.cluster_name}-${var.app}-${var.env}"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "node-${var.app}-${var.env}"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.subnets
  labels          = {
    type      = "cluster-node"
    lifecycle = "OnDemand"
  }

  remote_access {
    ec2_ssh_key = var.ssh_key_name
  }

  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  depends_on = [var.eks_node_depends]

  tags = {
    Environment = "eks-node-${var.app}-${var.env}"
  }
}
