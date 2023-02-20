output "instance_id" {
    description = "ID Instance"
value = ["${aws_instance.app_server.*.id}"]
}

output "instance_ip" {
  description = "Public IP"
  value = ["${aws_instance.app_server.*.public_ip}"]
}