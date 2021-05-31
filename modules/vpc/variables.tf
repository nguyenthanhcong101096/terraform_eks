variable "env" {
  default = "development"
}

variable "app" {
  default = "congnt"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_network_config" {
  type = map(object({
    cidr_block               = string
    az                       = string
    associated_public_subnet = string
    eks                      = bool
  }))

  default = {
    "public-eks-1" = {
      cidr_block               = "10.0.1.0/24"
      az                       = "ap-southeast-1a"
      associated_public_subnet = "public-eks-1"
      eks                      = false
    },
    "public-eks-2" = {
      cidr_block               = "10.0.2.0/24"
      az                       = "ap-southeast-1b"
      associated_public_subnet = "public-eks-2"
      eks                      = false
    }
  }
}

variable "private_network_config" {
  type = map(object({
    cidr_block               = string
    az                       = string
    associated_public_subnet = string
    eks                      = bool
  }))

  default = {
    "private-eks-1" = {
      cidr_block               = "10.0.3.0/24"
      az                       = "ap-southeast-1a"
      associated_public_subnet = "private-eks-1"
      eks                      = true
    },
    "private-eks-2" = {
      cidr_block               = "10.0.4.0/24"
      az                       = "ap-southeast-1b"
      associated_public_subnet = "private-eks-2"
      eks                      = true
    }
  }
}

locals {
  public_nested_config = flatten([
    for name, config in var.public_network_config : [
      {
        name                     = name
        cidr_block               = config.cidr_block
        az                       = config.az
        associated_public_subnet = config.associated_public_subnet
        eks                      = config.eks
      }
    ]
  ])
}

locals {
  private_nested_config = flatten([
    for name, config in var.private_network_config : [
      {
        name                     = name
        cidr_block               = config.cidr_block
        az                       = config.az
        associated_public_subnet = config.associated_public_subnet
        eks                      = config.eks
      }
    ]
  ])
}
