variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "name" {
  default     = "test"
  description = "the name of your stack, e.g. \"demo\""
}

variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = "TERRAFORM-TEST"
  type        = string
}
