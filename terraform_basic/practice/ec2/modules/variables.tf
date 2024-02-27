variable "aws_region" {
    type = string
    description = "Region"
    default = "us-east-2"  
}

variable "aws_access_key" {
    type = string
    description = "Access key"
    default = "AKIA4V2TOVRB6VTFN4UW"  
}

variable "aws_secret_key" {
    type = string
    description = "Secrect key"
    default = "yxwiOEFNMC4TUxfz2/GfA3ZOBFfO4t7ObQg8chHZ"  
}

variable "ami" {
    type = string
    description = "The instance AMI ID"
    default = "ami-05fb0b8c1424f266b"
}

variable "instance_type" {
    type = string
    description = "Instance type"
    default = "t2.micro"
}

variable "instance_name" {
    type = string
    description = "Instance name"
    default = "ec2-test-instance"
}