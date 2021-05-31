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

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "public-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.subnets
  labels          = {
    "type" = "cluster-node"
  }

  remote_access {
    ec2_ssh_key               = var.ssh_key_name
    source_security_group_ids = [var.node_security_group]
  }

  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [var.eks_node_depends]

  tags = {
    Environment = var.env
  }
}