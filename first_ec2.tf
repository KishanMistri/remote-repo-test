provider "aws" {
  region     = "us-west-2"
  access_key = "AKI********MWH"
  secret_key = "DPw********raHNQ2"
}

resource "aws_instance" "FirstEC2"{
  ami = "ami-0a36eb8fadc976275" 
  instance_type = "t2.micro"
}

