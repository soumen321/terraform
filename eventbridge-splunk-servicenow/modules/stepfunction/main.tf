resource "aws_sfn_state_machine" "splunk_query_workflow" {
  name     = "${var.project_name}-${var.environment}-splunk-query-workflow"
  role_arn = var.role_arn

  definition = jsonencode({
    Comment = "Step Function to process Splunk queries and create ServiceNow tickets"
    StartAt = "GetQueries"
    States = {
      GetQueries = {
        Type = "Task"
        Resource = var.lambda_arns.splunk_create_query
        Next = "ProcessQueries"
      }
      ProcessQueries = {
        Type = "Map"
        InputPath = "$.queries"
        MaxConcurrency = 10
        Iterator = {
          StartAt = "RunSplunkQuery"
          States = {
            RunSplunkQuery = {
              Type = "Task"
              Resource = var.lambda_arns.splunk_query_run_parse
              Next = "CheckQueryResult"
            }
            CheckQueryResult = {
              Type = "Choice"
              Choices = [
                {
                  Variable = "$.status"
                  StringEquals = "KO"
                  Next = "CreateServiceNowTicket"
                }
              ]
              Default = "QuerySuccess"
            }
            CreateServiceNowTicket = {
              Type = "Task"
              Resource = var.lambda_arns.servicenow
              End = true
            }
            QuerySuccess = {
              Type = "Pass"
              End = true
            }
          }
        }
        End = true
      }
    }
  })
}