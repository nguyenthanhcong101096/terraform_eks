module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "role" {
  source = "./modules/role"
}

module "eks" {
  source                 = "./modules/eks"
  eks_role_arn           = module.role.eks_role_arn
  cluster_security_group = module.security_group.eks_security_group_id

  subnets                = [
    module.vpc.private_subnets["private-eks-1"].id,
    module.vpc.private_subnets["private-eks-2"].id,
    module.vpc.public_subnets["public-eks-1"].id,
    module.vpc.public_subnets["public-eks-2"].id,
  ]

  depends                = [
    module.role.cluster_eks_cluster_policy,
    module.role.cluster_eks_vpc_resource_controller,
    module.role.eks_service_policy
  ]
}
