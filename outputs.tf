output "eip" {
  value = aws_eip.vm_eip.public_ip
}

output "instance" {
  value = aws_instance.web_server.id
}

output "elb-name" {
  value = aws_elb.web_instance_elb.id
}

output "elb-arn" {
  value = aws_elb.web_instance_elb.arn
}