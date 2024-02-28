
provider "aws" {
  region = "us-east-2"
}

module "ec2" {
  source        = "./modules"
  aws_region    = "us-east-2"
  ami           = "ami-05fb0b8c1424f266b"
  instance_type = "t2.micro"
  instance_name = "ec2-test-instance"
}
