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
  value = aws_instance.FirstEC2.
}

