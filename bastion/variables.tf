
variable "app" {
  description = "Application name"
}

variable "environment" {
  description = "Environment name"
}

variable "ami_id" {
  description = "AMI ID to use for app instance(s)"
}

variable "security_group_id" {
  description = "Security group ID to assign app instance(s) to"
}

variable "key_name" {
  description = "Key name to use for initializing the bastion instance"
}

variable "subnet_id" {
  description = "Subnet ID for app instance(s) to be launched in"
}

variable "instance_type" {
  description = "Instance type to use for bastion server"
  default = "t2.micro"
}
