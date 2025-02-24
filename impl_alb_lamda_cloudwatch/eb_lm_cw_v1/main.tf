module "lambda" {
  source = "./modules/lambda"

  lambda_function_name = var.lambda_function_name
  lambda_env_vars      = var.lambda_env_vars
  event_rule_arn       = module.eventbridge.event_rule_arn
}

module "eventbridge" {
  source = "./modules/eventbridge"

  event_rule_name      = var.event_rule_name
  asg_arn              = var.asg_arn
  lambda_function_arn  = module.lambda.lambda_function_arn
}

module "cloudwatch_alarm" {
  source = "./modules/cloudwatch_alarm"

  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_actions       = var.alarm_actions
  asg_name            = var.asg_name
}