provider "aws" {
  region = var.aws_region
}

# EventBridge Module
module "eventbridge" {
  source = "./modules/eventbridge"

  clip_regenerate_alarm_rule_name        = var.clip_regenerate_alarm_rule_name
  cloudwatch_status_rule_name            = var.cloudwatch_status_rule_name
  clip_ssmlamda_trigger_rule_name        = var.clip_ssmlamda_trigger_rule_name
  manage_cloudwatch_alarm_lambda_arn     = module.lambda.manage_cloudwatch_alarm_lambda_arn
  memory_usage_detection_lambda_arn      = module.lambda.memory_usage_detection_lambda_arn
  eventbridge_role_arn                   = module.iam.eventbridge_role_arn
  
  # Event pattern variables
  autoscaling_group_prefixes            = var.autoscaling_group_prefixes
  cloudwatch_status_alarm_prefixes      = var.cloudwatch_status_alarm_prefixes
  ssm_lambda_alarm_prefixes             = var.ssm_lambda_alarm_prefixes
}

# Lambda Module
module "lambda" {
  source = "./modules/lambda"

  manage_cloudwatch_alarm_lambda_name    = var.manage_cloudwatch_alarm_lambda_name
  memory_usage_detection_lambda_name     = var.memory_usage_detection_lambda_name
  manage_servicenow_alarm_lambda_name    = var.manage_servicenow_alarm_lambda_name
  lambda_role_arn                        = module.iam.lambda_role_arn
  s3_bucket                             = var.s3_bucket
  s3_key_manage_cloudwatch              = var.s3_key_manage_cloudwatch
  s3_key_memory_usage                   = var.s3_key_memory_usage
  s3_key_service_now                    = var.s3_key_service_now
  
  # Add EventBridge rule ARNs
  clip_regenerate_alarm_rule_arn         = module.eventbridge.clip_regenerate_alarm_rule_arn
  cloudwatch_status_rule_arn             = module.eventbridge.cloudwatch_status_rule_arn
  clip_ssmlamda_trigger_rule_arn         = module.eventbridge.clip_ssmlamda_trigger_rule_arn
  
  # Add SQS queue ARN
  service_now_queue_arn                  = module.sqs.service_now_queue_arn
}

# SQS Module
module "sqs" {
  source = "./modules/sqs"

  service_now_queue_name                 = var.service_now_queue_name
  manage_servicenow_alarm_lambda_arn     = module.lambda.manage_servicenow_alarm_lambda_arn
}

# IAM Module
module "iam" {
  source = "./modules/iam"

  lambda_policy_path                     = var.lambda_policy_path
  eventbridge_policy_path                = var.eventbridge_policy_path
}