variable db_engine {
  default = "mysql"
}

variable db_version {
  default = "5.7"
}

variable db_instance_class {
  default = "db.t2.micro"
}

variable rds_subnet_group {
  default = "rds-subnet-group"
}

variable private_subnets {
  type = any
}

variable rds_security_group {
  type = any
}
