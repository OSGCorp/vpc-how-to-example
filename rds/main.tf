
resource "aws_db_subnet_group" "main" {
    name = "${lower(var.app)}-main"
    subnet_ids = ["${var.subnets}"]

    tags = {
        Name = "Main"
        Application = "${var.app}"
    }
}

resource "aws_db_instance" "main" {
    identifier = "${lower(var.app)}-app"

    engine = "${var.engine}"
    engine_version = "${var.engine_version}"
    parameter_group_name = "${var.parameter_group}"
    option_group_name = "${var.option_group}"

    instance_class = "${var.instance_type}"
    storage_type = "${var.storage_type}"
    allocated_storage = "${var.storage}"

    username = "${var.username}"
    password = "${var.password}"

    multi_az = true
    vpc_security_group_ids = ["${var.security_group_id}"]
    db_subnet_group_name = "${aws_db_subnet_group.main.name}"

    # THIS IS FOR DEMO ONLY
    skip_final_snapshot = true
}
