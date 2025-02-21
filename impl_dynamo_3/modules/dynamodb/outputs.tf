output "dynamodb_table_name" {
  value = aws_dynamodb_table.default_cloudwatch_alarms.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.default_cloudwatch_alarms.arn
}