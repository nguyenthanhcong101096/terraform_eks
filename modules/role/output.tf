output "cluster_eks_cluster_policy" {
  value = aws_iam_role_policy_attachment.cluster_eks_cluster_policy
}

output "cluster_eks_vpc_resource_controller" {
  value = aws_iam_role_policy_attachment.cluster_eks_vpc_resource_controller
}

output "eks_service_policy" {
  value = aws_iam_role_policy_attachment.eks_service_policy
}

output "eks_role_arn" {
  value = aws_iam_role.eks.arn
}
