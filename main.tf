provider "aws" {
  region = "ap-south-1"
}
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH access"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web_server" {
  ami           = "ami-053b12d3152c0cc71" # Replace with the appropriate AMI
  instance_type = "t2.micro"
  key_name      = "Your-Key-Pair-Name"    # Replace with your key pair name
  security_groups = [aws_security_group.web_sg.name]
  tags = {
    Name = "Terraform-Instance"
  }
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              mkdir /home/ubuntu/my-website
              cd /home/ubuntu/my-website
              echo 'FROM nginx:latest' > Dockerfile
              echo 'COPY ./index.html /usr/share/nginx/html/index.html' >> Dockerfile
              echo 'This page is hosted on an EC2 instance with Docker' > index.html
              docker build -t my-web-app .
              docker run -d -p 80:80 my-web-app
            EOF
}
output "public_ip" {
  value = aws_instance.web_server.public_ip
}