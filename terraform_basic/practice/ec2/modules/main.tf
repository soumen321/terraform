# define provider
provider "aws" {
    access_key = var.aws_access_key
    region     = var.aws_region
    secret_key = var.aws_secret_key
}

#define resource
resource "aws_instance" "my_ec2_instances" {
    ami = var.ami
    instance_type = var.instance_type

    tags = {
        Name  = var.instance_name
    }
}

