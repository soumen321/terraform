provider "aws" {
  region = "us-east-1"
}

###  Compress-Archive -Path lambda_b.py -DestinationPath lambda_b.zip -Force

resource "aws_iam_role" "lambda_role" {
  name = "lambda_basic_execution"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

module "lambda_b" {
  source                 = "./modules/lambda"
  filename               = "${path.module}/lambda_b.zip"
  function_name          = local.lambda_b_name
  role_arn               = aws_iam_role.lambda_role.arn
  handler                = "lambda_b.lambda_handler"
  runtime                = "python3.9"
  environment_variables  = {}
}

module "lambda_a" {
  source                 = "./modules/lambda"
  filename               = "${path.module}/lambda_a.zip"
  function_name          = local.lambda_a_name
  role_arn               = aws_iam_role.lambda_role.arn
  handler                = "lambda_a.lambda_handler"
  runtime                = "python3.9"
}

resource "aws_lambda_permission" "allow_a_to_invoke_b" {
  statement_id  = "AllowExecutionFromLambdaA"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_b.lambda_function_arn
  principal     = "lambda.amazonaws.com"
  source_arn    = module.lambda_a.lambda_function_arn
}

resource "aws_cloudwatch_event_rule" "ec2_running" {
  name        = "ec2-instance-running"
  description = "Trigger Lambda A when EC2 instance enters running state"
  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    "detail": {
      "state": ["running"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_a" {
  rule      = aws_cloudwatch_event_rule.ec2_running.name
  target_id = "lambda-a"
  arn       = module.lambda_a.lambda_function_arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_invoke_a" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_a.lambda_function_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_running.arn
} 
