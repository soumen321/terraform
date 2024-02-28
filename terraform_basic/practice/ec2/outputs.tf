// define output variable

output "my_instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.my_instance_public_ip
}

