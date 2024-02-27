
module "ec2" {
  source         = "./modules"
  aws_region     = "us-east-2"
  aws_access_key = "AKIA4V2TOVRBRCSZRJEA"
  aws_secret_key = "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"
  ami            = "ami-05fb0b8c1424f266b"
  instance_type  = "t2.micro"
  instance_name  = "ec2-test-instance"
}