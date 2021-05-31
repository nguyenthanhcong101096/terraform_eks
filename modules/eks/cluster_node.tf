resource "aws_eks_node_group" "private" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "private-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.private_subnets

  labels          = {
    "type" = "private"
  }

  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  depends_on = [var.eks_node_depends]

  tags = {
    Environment = var.env
  }
}

resource "aws_eks_node_group" "public" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "public-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.public_subnets

  labels          = {
    "type" = "public"
  }

  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  depends_on = [var.eks_node_depends]

  tags = {
    Environment = var.env
  }
}
