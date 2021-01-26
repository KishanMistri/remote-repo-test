resource "aws_instance" "web_server" {
  ami           = var.region_ami[var.my_region]
  instance_type = var.instance_type[var.my_region]
  #count = 1
  tags = merge(
    local.general_tags,
    map(
      "Name", "web-server",
      "Role", "UI"
    )
  )
  #tags = local.general_tags
}
