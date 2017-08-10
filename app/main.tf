
resource "aws_instance" "app" {
    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    subnet_id = "${var.subnet_id[0]}"
    vpc_security_group_ids = ["${var.security_group_id}"]
    key_name = "${var.key_name}"

    root_block_device {
        volume_size = "${var.volume_size}"
    }

    tags {
        Name = "app"
        Application = "${var.app}"
        Environment = "${var.environment}"
    }
}

resource "aws_elb_attachment" "app" {
  elb = "${var.elb_id}"
  instance = "${aws_instance.app.id}"

  depends_on = ["aws_instance.app"]
}
