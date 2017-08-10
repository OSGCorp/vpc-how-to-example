resource "aws_eip" "nat" {
    count = "${length(var.availability_zones)}"
    vpc = true
}

resource "aws_nat_gateway" "app" {
    allocation_id = "${element(aws_eip.nat.*.id, 0)}"
    subnet_id     = "${element(aws_subnet.nat.*.id, 0)}"

    depends_on = ["aws_internet_gateway.main"]
}

resource "aws_route" "app-nat" {
  route_table_id = "${aws_route_table.app.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.app.*.id, 0)}"
}

