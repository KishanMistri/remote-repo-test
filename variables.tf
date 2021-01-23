variable "my_proxy_ip" {
  type    = string
  default = "100.100.1.1"
}

variable "my_region" {
  type    = string
  default = "us-west-2"
}
variable "region_ami" {
  type        = map(any)
  description = "Regionwise AMIs of ubuntu 18.04"
  default = {
    us-east-1 = "ami-0be2609ba883822ec"
    us-east-2 = "ami-0a0ad6b70e61be944"
    us-west-1 = "ami-03130878b60947df3"
    us-west-2 = "ami-0a36eb8fadc976275"
  }
}

variable "instance_type" {
  type = map(any)
  default = {
    us-east-1 = "t2.micro"
    us-west-2 = "t2.nano"
    us-east-2 = "t2.small"
    us-west-1 = "t2.micro"
  }
}

variable "az" {
  type    = list(any)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
variable "elb_timeout" {
  type    = number
  default = 300
}