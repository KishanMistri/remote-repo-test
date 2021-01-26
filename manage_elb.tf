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