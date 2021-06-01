variable "env" {
  default = "development"
}

variable "app" {
  default = "congnt"
}

variable "vpc_id" {
  type = any
}

variable "public_subnets" {
  type = any
}
