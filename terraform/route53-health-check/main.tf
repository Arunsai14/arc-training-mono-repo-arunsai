################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = "~> 0.15"
    }
  }

#   backend "s3" {}
}

provider "aws" {
  region = var.region
}


module "tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.5"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
  }
}

module "health_checks" {
  source = "sourcefuse/arc-healthcheck/aws"
  version     = "0.0.8"
  for_each = local.health_checks

  name                    = each.value.name
  domain_name             = contains(["prod"], var.environment) ? replace(each.value.domain_name, "-${var.environment}", ""): each.value.domain_name
  resource_path           = each.value.resource_path
  type                    = each.value.type
  measure_latency         = each.value.measure_latency
  alarm_prefix            = each.value.alarm_prefix
  failure_threshold       = each.value.failure_threshold
  request_interval        = each.value.request_interval
  alarm_endpoint_protocol = each.value.alarm_endpoint_protocol
  alarm_endpoint          = each.value.alarm_endpoint
  

  tags = module.tags.tags
}