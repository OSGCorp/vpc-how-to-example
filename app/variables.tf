
variable "ami_id" {
  description = "AMI ID to use for app instance(s)"
}

variable "subnet_id" {
  type = "list"
  description = "Subnet ID for app instance(s) to be launched in"
}

variable "security_group_id" {
  description = "Security group ID to assign app instance(s) to"
}

variable "key_name" {
  description = "Name of key to use for accessing instance(s) with"
}

variable "app" {
  description = "Name of the application being deployed"
}

variable "environment" {
  description = "ENV to launch into. e.g. development"
}

variable "elb_id" {
  description = "ELB ID to associate the app instance(s) with"
}

variable "app_route_table_id" {
  description = "Application route table ID"
}

variable "nat_gw_id" {
  description = "NAT Gateway ID that instances can use to reach outside"
}

variable "instance_type" {
  description = "Instance type to use for app instance(s)"
  default = "t2.micro"
}

variable "volume_size" {
  description = "ELB volume size for app instance(s) in GB"
  default = "10"
}
