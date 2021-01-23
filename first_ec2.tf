resource "aws_instance" "web_server"{
  ami = var.region_ami[var.my_region] 
  instance_type = var.instance_type[var.my_region]
  #count = 1
  tags = {
    name = "web-server"
  }
}
resource "aws_eip" "vm_eip"{
   vpc = true

}

output "eip" {
  value = aws_eip.vm_eip.public_ip
}

output "instance"{
  value = aws_instance.web_server.id
}


resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web_server.id
  allocation_id = aws_eip.vm_eip.id
}

resource "aws_security_group" "ssh_access" {
  name        = "KISHAN-SSH"
  
  ingress {
    description = "Allowing SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_proxy_ip}/32"]
  }

  tags = {
    Name = "SSH_ALLOWED"
  }
}

resource "aws_elb" "web_instance_elb" {
  name               = "web-instance-elb"
  availability_zones = var.az

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = var.elb_timeout
  connection_draining         = true
  connection_draining_timeout = var.elb_timeout

  tags = {
    Name = "terraform-managed-elb"
  }
}

# Create a new load balancer attachment
resource "aws_elb_attachment" "elb_instance_attachment" {
  elb      = aws_elb.web_instance_elb.id
  instance = aws_instance.web_server.id
}

output "elb-name"{
  value = aws_elb.web_instance_elb.id
}

output "elb-arn"{
  value = aws_elb.web_instance_elb.arn
}

output "elb-instance"{
  value = aws_elb.web_instance_elb.instances
}