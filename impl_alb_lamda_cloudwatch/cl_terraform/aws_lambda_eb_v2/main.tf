provider "aws" {
  region = "us-east-1"  # Change as per your requirement
}

module "lambda" {
  source = "./modules/lambda"

  function_name        = var.lambda_function_name
  lambda_exec_role_arn = module.iam.lambda_exec_role_arn
  s3_bucket_name       = var.s3_bucket_name
  s3_key_manage_cloudwatch = var.s3_key_manage_cloudwatch
  s3_key_memory_usage  = var.s3_key_memory_usage
  s3_key_service_now   = var.s3_key_service_now
}

module "eventbridge" {
  source = "./modules/eventbridge"

  lambda_function_arn            = module.lambda.lambda_arn
  memory_usage_detection_lambda_arn = module.lambda.memory_usage_detection_lambda_arn
  eventbridge_rules              = var.eventbridge_rules
}

module "sqs" {
  source = "./modules/sqs"

  sqs_queue_name                = var.sqs_queue_name
  fifo_queue                    = var.fifo_queue
  content_based_deduplication   = var.content_based_deduplication
  service_now_alarm_lambda_arn  = module.lambda.service_now_alarm_lambda_arn
  batch_size                    = var.sqs_batch_size
}

module "iam" {
  source = "./modules/iam"

  lambda_function_arn            = module.lambda.lambda_arn
  memory_usage_detection_lambda_arn = module.lambda.memory_usage_detection_lambda_arn
  service_now_alarm_lambda_arn   = module.lambda.service_now_alarm_lambda_arn
  sqs_queue_arn                  = module.sqs.sqs_queue_arn
}