module "keypair" {
  source = "./modules/keypair"
}

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

module "rds" {
  source             = "./modules/rds"
  rds_security_group = module.security_group.rds_security_group_id
  private_subnets    = [module.vpc.private_subnets["private-eks-1"].id, module.vpc.private_subnets["private-eks-2"].id]
}

module "eks" {
  source                 = "./modules/eks"
  eks_role_arn           = module.role.eks_role_arn
  cluster_security_group = module.security_group.eks_security_group_id

  subnets                = [
    # module.vpc.private_subnets["private-eks-1"].id,
    # module.vpc.private_subnets["private-eks-2"].id,
    module.vpc.public_subnets["public-eks-1"].id,
    module.vpc.public_subnets["public-eks-2"].id
  ]

  eks_depends            = [
    module.role.cluster_eks_cluster_policy,
    module.role.cluster_eks_vpc_resource_controller,
    module.role.cluster_eks_service_policy
  ]

  eks_node_role_arn   = module.role.eks_node_role_arn
  ssh_key_name        = module.keypair.key_name
  node_security_group = module.security_group.eks_node_security_group_id

  eks_node_depends    = [
    module.role.nodes_eks_worker_node_policy,
    module.role.nodes_eks_cni_policy,
    module.role.nodes_ec2_container_registry_read_only
  ]
}
