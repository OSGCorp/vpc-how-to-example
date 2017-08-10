
variable "cidr" {
    description = "CIDR block for the VPC"
}

variable "app" {
    description = "Application name"
}

variable "environment" {
    description = "Environment name"
}

variable "availability_zones" {
    type = "list"
    description = "Availability zones to launch instances into"
}

