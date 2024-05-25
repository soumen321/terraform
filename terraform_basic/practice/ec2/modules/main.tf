# define provider
provider "aws" {
  region = var.aws_region
}

#define resource
resource "aws_instance" "my_ec2_instances" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

