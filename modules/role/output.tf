################################## EKS ########################################
output "eks_role_arn" {
  value = aws_iam_role.eks.arn
}

output "cluster_eks_cluster_policy" {
  value = aws_iam_role_policy_attachment.cluster_eks_cluster_policy
}

output "cluster_eks_vpc_resource_controller" {
  value = aws_iam_role_policy_attachment.cluster_eks_vpc_resource_controller
}

output "eks_service_policy" {
  value = aws_iam_role_policy_attachment.eks_service_policy
}

##################################### EKS NODE ########################################
output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "nodes_eks_worker_node_policy" {
  value = aws_iam_role_policy_attachment.nodes_eks_worker_node_policy
}

output "nodes_eks_cni_policy" {
  value = aws_iam_role_policy_attachment.nodes_eks_cni_policy
}

output "nodes_ec2_container_registry_read_only" {
  value = aws_iam_role_policy_attachment.nodes_ec2_container_registry_read_only
}
