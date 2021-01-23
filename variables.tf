variable "my_proxy_ip"{
    default = "100.100.1.1"
} 

variable "instance_type"{
    type = string
    default = "t2.micro"
} 

variable "az" {
    type = list
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
variable "elb_timeout" {
    type = number
    default = 300
}