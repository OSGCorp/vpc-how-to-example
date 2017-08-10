
variable "app" {
  description = "Name of the application for the DB"
}

variable "subnets" {
  type = "list"
  description = "List of subnets for the DB. Minimum is 2"
}

variable "username" {
  description = "Master username for the DB"
}

variable "password" {
  description = "Master password for the DB"
}

variable "security_group_id" {
  description = "Security group for RDS"
}

variable "engine" {
  description = "Database type to use"
  default = "postgres"
}

variable "engine_version" {
  description = "Version of the DB to use"
  default = "9.6.1"
}

variable "storage" {
  description = "How big to make the DB in GB"
  default = "10"
}

variable "instance_type" {
  description = "Instance type for DB server"
  default = "db.t2.small"
}

variable "storage_type" {
  description = "What kind of storage medium to use for DB"
  default = "standard"
}

variable "parameter_group" {
  description = "Paramters to use for DB"
  default = "default.postgres9.6"
}

variable "option_group" {
  description = "Options to use for DB"
  default = "default:postgres-9-6"
}
