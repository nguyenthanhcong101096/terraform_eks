output "eks_security_group_id" {
  value = aws_security_group.eks_cluster.id
}

output "eks_node_security_group_id" {
  value = aws_security_group.eks_nodes.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}
