################################################################
## defaults
################################################################
terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }

     awsutils = {
      source  = "cloudposse/awsutils"
      version = "~> 0.15"
    }
  }

  #backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.5"

  environment = var.environment
  project     = var.namespace

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/cloudfront"
  }
}

provider "awsutils" {
  region = var.region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

}



################################################################################
## CloudFront
################################################################################
module "cloudfront" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-cloudfront?ref=4.0.3"

  for_each = local.distributions

  origins                = each.value.origins
  namespace              = each.value.namespace
  description            = each.value.description
  default_root_object    = each.value.default_root_object
  route53_root_domain    = each.value.route53_root_domain
  create_route53_records = each.value.create_route53_records
  aliases                = each.value.aliases
  enable_logging         = each.value.enable_logging

  default_cache_behavior = each.value.default_cache_behavior
  viewer_certificate     = each.value.viewer_certificate

  acm_details            = each.value.acm_details
  custom_error_responses = each.value.custom_error_responses
  price_class            = each.value.price_class
  # web_acl_id              = each.value.web_acl_id

  providers = {
    aws.acm = aws.us_east_1 # Specify the provider for this module
  }

  tags = module.tags.tags
}