
resource "aws_elb" "main" {
  name = "elb"
  subnets = ["${aws_subnet.elb.*.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout = 5
    target  = "HTTP:8000/"
    interval = 10
  }

  tags {
    Application = "${var.app}"
  }
}
