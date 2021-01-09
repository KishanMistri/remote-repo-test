resource "aws_instance" "FirstEC2"{
  ami = "ami-0a36eb8fadc976275" 
  instance_type = "t2.micro"
}