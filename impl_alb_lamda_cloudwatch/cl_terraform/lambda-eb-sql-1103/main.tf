terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

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

# VPC Module
# module "vpc" {
#   source = "./modules/vpc"

#   environment        = var.environment
#   vpc_cidr          = var.vpc_cidr
#   private_subnets   = var.private_subnets
#   availability_zones = var.availability_zones
#   aws_region        = var.aws_region
# }

# IAM Module
module "iam" {
  source = "./modules/iam"

  lambda_functions = {
    "${var.manage_cloudwatch_alarm_lambda_name}" = {
      filename = data.archive_file.manage_cloudwatch_alarm.output_path
      handler   = "index.handler"
      runtime   = "python3.9"
    }
    "${var.memory_usage_detection_lambda_name}" = {
      filename = data.archive_file.memory_usage_detection.output_path
      handler   = "index.handler"
      runtime   = "python3.9"
    }
    "${var.manage_servicenow_alarm_lambda_name}" = {
      filename = data.archive_file.service_now_alarm.output_path
      handler   = "index.handler"
      runtime   = "python3.9"
    }
  }
}

# Lambda Module
module "lambda" {
  source = "./modules/lambda"

  lambda_functions = {
    "${var.manage_cloudwatch_alarm_lambda_name}" = {
      filename     = data.archive_file.manage_cloudwatch_alarm.output_path
      source_code_hash = data.archive_file.manage_cloudwatch_alarm.output_base64sha256
      handler       = "index.handler"
      runtime       = "python3.9"
      role_arn     = module.iam.lambda_role_arns[var.manage_cloudwatch_alarm_lambda_name]
      # vpc_config = {
      #   subnet_ids         = module.vpc.private_subnet_ids
      #   security_group_ids = [module.vpc.lambda_security_group_id]
      # }
    }
    "${var.memory_usage_detection_lambda_name}" = {
      filename     = data.archive_file.memory_usage_detection.output_path
      source_code_hash = data.archive_file.memory_usage_detection.output_base64sha256
      handler       = "index.handler"
      runtime       = "python3.9"
      role_arn     = module.iam.lambda_role_arns[var.memory_usage_detection_lambda_name]
      # vpc_config = {
      #   subnet_ids         = module.vpc.private_subnet_ids
      #   security_group_ids = [module.vpc.lambda_security_group_id]
      # }
    }
    "${var.manage_servicenow_alarm_lambda_name}" = {
      filename     = data.archive_file.service_now_alarm.output_path
      source_code_hash = data.archive_file.service_now_alarm.output_base64sha256
      handler       = "index.handler"
      runtime       = "python3.9"
      role_arn     = module.iam.lambda_role_arns[var.manage_servicenow_alarm_lambda_name]
      layers       = [var.servicenow_layer_arn]
      # vpc_config = {
      #   subnet_ids         = module.vpc.private_subnet_ids
      #   security_group_ids = [module.vpc.lambda_security_group_id]
      # }
    }
  }
}

# EventBridge Module
module "eventbridge" {
  source = "./modules/eventbridge"
  depends_on = [module.lambda]

  eventbridge_rules = {
    "${var.clip_regenerate_alarm_rule_name}" = {
      description = "Rule for Auto Scaling Group events"
      pattern     = jsonencode({
        source      = ["aws.autoscaling"]
        detail-type = [
          "EC2 Instance-terminate Lifecycle Action",
          "EC2 Instance Launch Successful"
        ]
        detail = {
          AutoScalingGroupName = [for prefix in var.autoscaling_group_prefixes : { prefix = prefix }]
        }
      })
      targets     = [var.manage_cloudwatch_alarm_lambda_name]
      role_arn    = module.iam.eventbridge_role_arn
      target_arn  = module.lambda.function_arns[var.manage_cloudwatch_alarm_lambda_name]
    }
    "${var.cloudwatch_status_rule_name}" = {
      description = "Rule for CloudWatch alarms status"
      pattern     = jsonencode({
        source      = ["aws.cloudwatch"]
        detail-type = ["CloudWatch Alarm State Change"]
        detail = {
          alarmName = [for prefix in var.cloudwatch_status_alarm_prefixes : { prefix = prefix }]
        }
      })
      targets     = [var.manage_cloudwatch_alarm_lambda_name]
      role_arn    = module.iam.eventbridge_role_arn
      target_arn  = module.lambda.function_arns[var.manage_cloudwatch_alarm_lambda_name]
    }
    "${var.clip_ssmlamda_trigger_rule_name}" = {
      description = "Rule for SSM Lambda triggers"
      pattern     = jsonencode({
        source      = ["aws.cloudwatch"]
        detail-type = ["CloudWatch Alarm State Change"]
        detail = {
          alarmName = [for prefix in var.ssm_lambda_alarm_prefixes : { prefix = prefix }]
        }
      })
      targets     = [var.memory_usage_detection_lambda_name]
      role_arn    = module.iam.eventbridge_role_arn
      target_arn  = module.lambda.function_arns[var.memory_usage_detection_lambda_name]
      input_transformer = {
        input_paths = {
          instanceid  = "$.detail.instance-id"
          alarmname   = "$.detail.alarmName"
          metricname  = "$.detail.metricName"
          statevalue  = "$.detail.state.value"
        }
        input_template = <<EOF
{
  "instanceId": <instanceid>,
  "alarmName": <alarmname>,
  "metricName": <metricname>,
  "stateValue": <statevalue>
}
EOF
      }
    }
  }
}

# Lambda permissions for EventBridge
resource "aws_lambda_permission" "eventbridge_invoke" {
  for_each = module.eventbridge.rule_arns

  statement_id  = "AllowEventBridgeInvoke-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = lookup(
    {
      "${var.clip_regenerate_alarm_rule_name}" = var.manage_cloudwatch_alarm_lambda_name,
      "${var.cloudwatch_status_rule_name}" = var.manage_cloudwatch_alarm_lambda_name,
      "${var.clip_ssmlamda_trigger_rule_name}" = var.memory_usage_detection_lambda_name
    },
    each.key
  )
  principal     = "events.amazonaws.com"
  source_arn    = each.value
}

# SQS Module
module "sqs" {
  source = "./modules/sqs"
  depends_on = [module.lambda]

  queues = {
    "${trimsuffix(var.service_now_queue_name, ".fifo")}" = {
      fifo_queue                  = true
      content_based_deduplication = true
      target_lambda              = var.manage_servicenow_alarm_lambda_name
      role_arn                   = module.iam.sqs_role_arn
    }
  }
  lambda_function_arns = module.lambda.function_arns
}