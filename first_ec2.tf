resource "aws_eip" "vm_eip"{
   vpc = true
}

output "eip" {
  value = aws_eip.vm_eip.public_ip
}

resource "aws_instance" "FirstEC2"{
  ami = "ami-0a36eb8fadc976275" 
  instance_type = "t2.micro"
  //associate_public_ip_address = eip
}
output "instance"{
  value = aws_instance.FirstEC2.id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.FirstEC2.id
  allocation_id = aws_eip.vm_eip.id
}

resource "aws_security_group" "ssh-access" {
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