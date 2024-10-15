################################################################
## shared
################################################################
variable "project_name" {
  type        = string
  description = "Name of the project."
  default     = "arc"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-2"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "namespace" {
  type        = string
  description = "Namespace for the resources."
  default     = "arc"
}
