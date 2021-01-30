resource "aws_security_group" "ssh_access" {
  name = "Alllow 22 - Kishan"

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
/*
resource "aws_network_interface_sg_attachment" "ssh_sg_attachment" {
  security_group_id    = aws_security_group.ssh_access.id
  network_interface_id = aws_instance.web_server.primary_network_interface_id
}
*/
resource "aws_security_group" "world_access" {
  name = "World-Access-Ports-SG"
  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value # Changed value from ingress to port using iterator for more readability 
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "Others"
  }
}
/*
resource "aws_network_interface_sg_attachment" "web_sg_attachment" {
  security_group_id    = aws_security_group.world_access.id
  network_interface_id = aws_instance.web_server.primary_network_interface_id
}
*/
