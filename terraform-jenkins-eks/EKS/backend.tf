terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-soumen"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}