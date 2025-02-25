provider "aws" {
  region = var.aws_region
}



module "eventbridge" {
  source = "./modules/eventbridge"

  eventbridge_name = var.eventbridge_name
  asg_name_prefix  = var.asg_name_prefix
  lambda_arn       = module.lambda.lambda_arn
  lambda_function_name = module.lambda.lambda_function_name
}

module "lambda" {
  source = "./modules/lambda"

  lambda_function_name = var.lambda_function_name
  s3_bucket           = var.s3_bucket
  s3_key              = var.s3_key
  handler             = var.handler
  runtime             = var.runtime
  role_arn            = module.iam.lambda_role_arn
  eventbridge_arn     = module.eventbridge.eventbridge_arn 
}

module "iam" {
  source = "./modules/iam"

  lambda_function_name = var.lambda_function_name
  s3_bucket           = var.s3_bucket
  s3_key              = var.s3_key
}