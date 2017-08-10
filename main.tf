provider "aws" {
  version = "~> 0.1"
  region = "${var.region}"
}

module "vpc" {
  source = "./vpc"

  cidr = "${var.cidr}"
  app = "${var.app}"
  environment = "${var.environment}"
  availability_zones = "${var.availability_zones}"
}

module "rds" {
  source = "./rds"

  app = "${var.app}"
  subnets = ["${split(",", module.vpc.rds_subnet_ids)}"]
  username = "${var.master_db_username}"
  password = "${var.master_db_password}"
  security_group_id = "${module.vpc.rds_security_group_id}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "name"
    values = ["*ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "app" {
  source = "./app"

  app = "${var.app}"
  ami_id = "${data.aws_ami.ubuntu.id}"
  subnet_id = "${module.vpc.app_subnet_ids}"
  security_group_id = "${module.vpc.app_security_group_id}"
  key_name = "${var.key_name}"
  elb_id = "${module.vpc.elb_id}"
  nat_gw_id = "${module.vpc.nat_gw_id}"
  app_route_table_id = "${module.vpc.app_route_table_id}"
  environment = "${var.environment}"
}

module "bastion" {
  source = "./bastion"

  app = "${var.app}"
  ami_id = "${data.aws_ami.ubuntu.id}"
  subnet_id = "${module.vpc.bastion_subnet_id}"
  security_group_id = "${module.vpc.bastion_security_group_id}"
  key_name = "${var.key_name}"
  environment = "${var.environment}"
}

