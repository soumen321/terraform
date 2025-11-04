project_name = "evt-brdg-splunk-servicenow"
environment  = "prod"
aws_region   = "us-east-1"

# Network Configuration
private_subnet_ids = [
  "subnet-0e1d79683bb0c1cb8", # Replace with your private subnet IDs
  "subnet-08ac123844228dc05"
]

# Existing Security Group IDs
lambda_security_group_ids = [
  "sg-0c9dc0440934308f5"  # Replace with your security group ID
]

# DynamoDB KMS Key ARN (your existing KMS key)
dynamodb_kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-a123-456a-a12b-a123b4cd56ef"