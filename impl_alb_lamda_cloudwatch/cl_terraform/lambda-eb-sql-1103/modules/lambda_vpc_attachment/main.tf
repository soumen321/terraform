resource "aws_lambda_function_vpc_config" "attachment" {
  for_each = var.lambda_functions

  function_name    = each.key
  subnet_ids       = var.subnet_ids
  security_groups  = var.security_group_ids

  depends_on = [aws_iam_role_policy_attachment.lambda_vpc_access]
}

# Add VPC access policy to existing Lambda roles
resource "aws_iam_role_policy_attachment" "lambda_vpc_access" {
  for_each = var.lambda_functions

  role       = each.value.role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}