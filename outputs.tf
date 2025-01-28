output "ec2_public_ip" {
  value = aws_instance.MyTerraformInstance.public_ip
}
