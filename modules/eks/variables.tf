variable "env" {
  default = "development"
}

variable "cluster_name" {
  default = "my-cluster"
}

variable "eks_role_arn" {
  type = any
}

variable "eks_node_role_arn" {
  type = any
}

variable "eks_depends" {
  type = list
}

variable "cluster_security_group" {
  type = any
}

variable "subnets" {
  type = any
}

variable "public_subnets" {
  type = any
}

# variable "private_subnets" {
#   type = any
# }

variable "eks_node_depends" {
  type = any
}

variable "node_security_group" {
  type = any
}

variable "ssh_key_name" {
  type = any
}
