output "step_function_arn" {
  description = "ARN of the Step Function"
  value       = aws_sfn_state_machine.splunk_query_workflow.arn
}