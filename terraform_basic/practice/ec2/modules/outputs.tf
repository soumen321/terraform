// define output variable

output "my_instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.my_ec2_instances.public_ip
}

