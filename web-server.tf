resource "aws_instance" "web_server" {
  ami             = var.region_ami[var.my_region]
  instance_type   = var.instance_type[var.my_region]
  key_name        = var.webserver_keypair
  vpc_security_group_ids = [aws_security_group.ssh_access.id, aws_security_group.world_access.id]
  # security_groups = [aws_security_group.ssh_access.id, aws_security_group.world_access.id]
  #count = 1

  provisioner "remote-exec" {
    inline = [
      #"sudo su - && apt-get update && apt-get install -y lsb-release && apt-get clean all"
      "sudo amazon-linux-extras install epel -y",
      "sudo yum-config-manager --enable epel",
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("C:/Users/Kishan/.ssh/webserver_keypair.pem")
    }
  }
  tags = merge(
    local.general_tags,
    {
      "Name" = "web-server",
      "Role" = "UI"
    }
  )
  #tags = local.general_tags
}
