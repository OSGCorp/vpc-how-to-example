
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "ig_id" {
  value = "${aws_internet_gateway.main.id}"
}

output "rds_subnet_ids" {
  value = "${join(",", aws_subnet.rds.*.id)}"
}

output "rds_security_group_id" {
  value = "${aws_security_group.rds.id}"
}

output "app_subnet_ids" {
  value = ["${aws_subnet.app.*.id}"]
}

output "app_security_group_id" {
  value = "${aws_security_group.app.id}"
}

output "elb_id" {
  value = "${aws_elb.main.id}"
}

output "nat_gw_id" {
  value = "${aws_nat_gateway.app.id}"
}

output "app_route_table_id" {
  value = "${aws_route_table.app.id}"
}

output "bastion_subnet_id" {
  value = "${aws_subnet.bastion.id}"
}

output "bastion_security_group_id" {
  value = "${aws_security_group.bastion.id}"
}
