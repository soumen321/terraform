# Create ZIP files for Lambda functions
data "archive_file" "manage_cloudwatch_alarm" {
  type        = "zip"
  source_dir  = "${path.module}/lambdacode/manage_cloudwatch_alarm"
  output_path = "${path.module}/lambdacode/manage_cloudwatch_alarm.zip"
}

data "archive_file" "memory_usage_detection" {
  type        = "zip"
  source_dir  = "${path.module}/lambdacode/memory_usage_detection"
  output_path = "${path.module}/lambdacode/memory_usage_detection.zip"
}

data "archive_file" "service_now_alarm" {
  type        = "zip"
  source_dir  = "${path.module}/lambdacode/service_now_alarm"
  output_path = "${path.module}/lambdacode/service_now_alarm.zip"
}
