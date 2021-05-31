resource "aws_security_group" "eks" {
  name        = "eks_sg_ControlPlaneSecurityGroup"
  description = "eks_sg_ControlPlaneSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ControlPlaneSecurityGroup"
    Environment = var.env
  }
}

resource "aws_security_group" "eks_nodes" {
  name        = "ClusterSharedNodeSecurityGroup"
  description = "Communication between all nodes in the cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.eks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ClusterSharedNodeSecurityGroup"
    Environment = var.env
  }
}

resource "aws_security_group_rule" "cluster_inbound" {
  description              = "Allow unmanaged nodes to communicate with control plane (all ports)"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port                  = 0
  type                     = "ingress"
}
