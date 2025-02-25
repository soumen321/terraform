aws_region          = "us-east-1"
eventbridge_name    = "cl-regenerate-alarm"
asg_name_prefix     = ["pop-lab", "clip-lab"]
lambda_function_name = "manage-cloudwatch-alarm"
s3_bucket           = "managealarmv1"
s3_key              = "manage_cloudwatch_alarm.zip"
handler             = "lambda_function.lambda_handler"
runtime             = "python3.9"