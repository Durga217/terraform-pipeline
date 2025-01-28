provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "example" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name      = "Durga-Test"
  subnet_id     = "subnet-0e67a89dc05c9fad9"
  vpc_security_group_ids = ["sg-04a64f749116231c8"]
  associate_public_ip_address = true
  tags = {
    Name = "MyTerraformInstance"
  }
}
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
