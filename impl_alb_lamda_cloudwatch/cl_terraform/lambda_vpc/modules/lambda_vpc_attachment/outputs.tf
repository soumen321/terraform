output "lambda_vpc_configs" {
  description = "Map of Lambda function names to their VPC configurations"
  value = {
    for k, v in aws_lambda_function_vpc_config.attachment : k => {
      subnet_ids      = v.subnet_ids
      security_groups = v.security_groups
    }
  }
}