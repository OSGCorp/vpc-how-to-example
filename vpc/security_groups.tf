resource "aws_security_group" "elb" {
    name = "elb"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "elb"
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

resource "aws_security_group_rule" "elb-http" {
  security_group_id = "${aws_security_group.elb.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "app" {
    name = "app"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "app"
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

resource "aws_security_group_rule" "app-http" {
  security_group_id = "${aws_security_group.app.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "app-ssh" {
  security_group_id = "${aws_security_group.app.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group" "rds" {
    name = "rds"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "rds"
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

resource "aws_security_group_rule" "rds-app" {
  security_group_id = "${aws_security_group.rds.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group" "nat" {
    name = "nat"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "nat"
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

resource "aws_security_group_rule" "nat-http" {
  security_group_id = "${aws_security_group.nat.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "nat-https" {
  security_group_id = "${aws_security_group.nat.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group" "bastion" {
  name = "bastion"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "bastion"
    Application = "${var.app}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "bastion-ssh" {
  security_group_id = "${aws_security_group.bastion.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
