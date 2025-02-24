variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
}

variable "comparison_operator" {
  description = "Comparison operator for the alarm"
  type        = string
}

variable "evaluation_periods" {
  description = "Number of evaluation periods"
  type        = number
}

variable "metric_name" {
  description = "Name of the metric"
  type        = string
}

variable "namespace" {
  description = "Namespace for the metric"
  type        = string
}

variable "period" {
  description = "Period in seconds"
  type        = number
}

variable "statistic" {
  description = "Statistic for the metric"
  type        = string
}

variable "threshold" {
  description = "Threshold for the alarm"
  type        = number
}

variable "alarm_actions" {
  description = "List of ARNs to trigger when the alarm state is reached"
  type        = list(string)
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}