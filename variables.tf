
variable "key_name" {
  description = "PEM key name used to initialize instances with"
}

variable "master_db_username" {
  description = "Master username for RDS instance(s)"
}

variable "master_db_password" {
  description = "Master password for RDS instance(s)"
}

variable "app" {
  description = "Infrastructure name"
  default = "vpc-how-to"
}

variable "environment" {
  description = "Environment name"
  default = "development"
}

variable "region" {
  description = "AWS Region to deploy into"
  default = "us-east-1"
}

variable "availability_zones" {
  type = "list"
  description = "Availability zones to deploy into"
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "cidr" {
  description = "CIDR block to use for the VPC. All subnets are derived from this block"
  default = "10.0.0.0/24"
}

variable "cidr_block_size" {
  description = "Total number of IPs within each subnet block"
  default = 4
}
