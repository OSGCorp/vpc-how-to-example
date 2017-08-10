resource "aws_subnet" "app" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${var.availability_zones[count.index]}"
  cidr_block = "${cidrsubnet(var.cidr, 4, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Index = "${count.index}"
    Name = "App ${count.index}"
    Application = "${var.app}"
  }
}

resource "aws_subnet" "rds" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${var.availability_zones[count.index]}"
  cidr_block = "${cidrsubnet(var.cidr, 4, count.index + length(var.availability_zones))}"
  map_public_ip_on_launch = false

  tags {
    Index = "${count.index}"
    Name = "RDS ${count.index}"
    Application = "${var.app}"
  }
}

resource "aws_subnet" "elb" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${var.availability_zones[count.index]}"
  cidr_block = "${cidrsubnet(var.cidr, 4, count.index + length(var.availability_zones)*2)}"
  map_public_ip_on_launch = false

  tags {
    Index = "${count.index}"
    Name = "ELB ${count.index}"
    Application = "${var.app}"
  }
}

resource "aws_subnet" "nat" {
  count = "${length(var.availability_zones)}"

  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${var.availability_zones[count.index]}"
  cidr_block = "${cidrsubnet(var.cidr, 4, count.index + length(var.availability_zones)*3)}"
  map_public_ip_on_launch = true

  tags {
    Index = "${count.index}"
    Name = "NAT"
    Application = "${var.app}"
  }
}

resource "aws_subnet" "bastion" {
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${var.availability_zones[0]}"
  cidr_block = "${cidrsubnet(var.cidr, 4, length(var.availability_zones)*4)}"
  map_public_ip_on_launch = true

  tags {
    Name = "Bastion"
    Application = "${var.app}"
  }
}
