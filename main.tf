provider "aws" {
  region = var.aws_region
}
resource "aws_instance" "example" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = "subnet-0e67a89dc05c9fad9"
  vpc_security_group_ids = ["sg-04a64f749116231c8"]
  associate_public_ip_address = true
  tags = {
    Name = "MyTerraformInstance"
  }
}
