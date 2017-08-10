
resource "aws_route_table" "app" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "App"
    Application = "${var.app}"
    Role = "App"
  }
}

resource "aws_route_table_association" "app" {
  count = "${length(var.availability_zones)}"

  subnet_id = "${element(aws_subnet.app.*.id, count.index)}"
  route_table_id = "${aws_route_table.app.id}"
}

resource "aws_route_table" "rds" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "RDS"
    Application = "${var.app}"
    Role = "RDS"
  }
}

resource "aws_route_table_association" "rds" {
  count = "${length(var.availability_zones)}"

  subnet_id = "${aws_subnet.rds.*.id[count.index]}"
  route_table_id = "${aws_route_table.rds.id}"
}

resource "aws_route_table" "elb" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "ELB"
    Application = "${var.app}"
    Role = "ELB"
  }
}

resource "aws_route_table_association" "elb" {
  count = "${length(var.availability_zones)}"

  subnet_id = "${aws_subnet.elb.*.id[count.index]}"
  route_table_id = "${aws_route_table.elb.id}"
}

resource "aws_route" "elb_public" {
  route_table_id = "${aws_route_table.elb.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table" "nat" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "NAT"
    Application = "${var.app}"
    Role = "NAT"
  }
}

resource "aws_route_table_association" "nat" {
  count = "${length(var.availability_zones)}"

  subnet_id = "${aws_subnet.nat.*.id[count.index]}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route" "nat_public" {
  route_table_id = "${aws_route_table.nat.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table_association" "bastion" {
  subnet_id = "${aws_subnet.bastion.id}"
  route_table_id = "${aws_vpc.main.default_route_table_id}"
}

resource "aws_route" "bastion" {
  route_table_id = "${aws_vpc.main.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.main.id}"
}

