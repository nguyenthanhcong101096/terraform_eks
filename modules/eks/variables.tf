variable "env" {
  default = "development"
}

variable "cluster_name" {
  default = "my-cluster"
}

variable "eks_role_arn" {
  type = any
}

variable "depends" {
  type = list
}

variable "cluster_security_group" {
  type = any
}

variable "subnets" {
  type = any
}
