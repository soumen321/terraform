// define output variable

output "my_instance" {
  value = aws_instance.my_ec2_instances.public_ip
}