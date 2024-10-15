#######################################################################
## shared
#######################################################################
variable "environment" {
  type        = string
  default     = "poc"
  description = "environment value, e.g 'prod', 'staging', 'dev', 'UAT'"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "The project name"
  default     = "arc"
}

# variable "health_checks" {
#   type = map(object({
#     name                    = string
#     domain_name             = string
#     resource_path           = string
#     type                    = string
#     measure_latency         = bool
#     alarm_prefix            = string
#     failure_threshold       = number
#     request_interval        = number
#     search_string           = string
#     alarm_endpoint          = string
#     alarm_endpoint_protocol = string
#   }))
# }