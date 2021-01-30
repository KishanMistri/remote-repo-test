resource "aws_instance" "web_server" {
  ami             = var.region_ami[var.my_region]
  instance_type   = var.instance_type[var.my_region]
  key_name        = var.webserver_keypair
  security_groups = [aws_security_group.ssh_access.id, aws_security_group.world_access.id]
  #count = 1

  provisioner "remote-exec" {
    inline = [
      "amazon-linux-extras install nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.webserver_keypair_localpath)
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
