provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"

  project_name         = var.project_name
  environment          = var.environment
  dynamodb_kms_key_arn = var.dynamodb_kms_key_arn
}

module "lambda" {
  source = "./modules/lambda"

  project_name                    = var.project_name
  environment                     = var.environment
  splunk_create_query_role_arn    = module.iam.splunk_create_query_role_arn
  splunk_query_run_parse_role_arn = module.iam.splunk_query_run_parse_role_arn
  servicenow_role_arn             = module.iam.servicenow_role_arn
  private_subnet_ids              = var.private_subnet_ids
  lambda_security_group_ids       = var.lambda_security_group_ids
}

module "stepfunction" {
  source = "./modules/stepfunction"

  project_name = var.project_name
  environment  = var.environment
  role_arn     = module.iam.step_function_role_arn
  lambda_arns  = module.lambda.lambda_arns
}

module "eventbridge" {
  source = "./modules/eventbridge"

  project_name        = var.project_name
  environment         = var.environment
  step_function_arn  = module.stepfunction.step_function_arn
}