variable "aws_region" {
  type        = string
  description = "Region"
  # default = "us-east-2"  
}

variable "ami" {
  type        = string
  description = "The instance AMI ID"
  # default = ""
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  # default = ""
}

variable "instance_name" {
  type        = string
  description = "Instance name"
  # default = "ec2-test-instance"
}
