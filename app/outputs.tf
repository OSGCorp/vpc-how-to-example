output "app_ip" {
  value = "${aws_instance.app.private_ip}"
}
