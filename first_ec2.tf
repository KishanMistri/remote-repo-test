provider "aws" {
  region     = "us-west-2"
  access_key = "AKIARDP5QNXDGY4YUMWH"
  secret_key = "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"
}

resource "aws_instance" "FirstEC2"{
  ami = "ami-0a36eb8fadc976275" 
  instance_type = "t2.micro"
}

