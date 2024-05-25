terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.10.0"
    }
  }
}

provider "aws" {
    # Configuration option
    region = "us-east-1"
}