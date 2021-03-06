
resource "aws_vpc" "main" {
    cidr_block = "${var.cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

