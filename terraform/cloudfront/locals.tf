locals {
     distributions = {
    for index, distribution in local.distribution_data[var.environment] :
    distribution.id => distribution
  }

  distribution_data = {
    "dev" = [
      {
        id = "arc-training-sf-1409",
        origins = [{
          origin_type   = "s3",
          origin_id     = "arc-training-sf-1409",
          domain_name   = "",
          bucket_name   = "arc-training-sf-1409",
          create_bucket = false
          }
        ],
        namespace              = var.namespace,
        description            = "Distribution for dev",
        default_root_object    = "index.html"
        route53_root_domain    = "divyasf.sourcef.us"
        create_route53_records = true,
        aliases                = ["sf.divyasf.sourcef.us"],
        enable_logging         = false,
        default_cache_behavior = {
          origin_id              = "arc-training-sf-1409"
          allowed_methods        = ["GET", "HEAD"]
          cached_methods         = ["GET", "HEAD"]
          compress               = false
          viewer_protocol_policy = "redirect-to-https"

          use_aws_managed_cache_policy            = true
          cache_policy_name                       = "CachingOptimized"
          use_aws_managed_origin_request_policy   = true
          origin_request_policy_name              = "CORS-S3Origin"
          response_headers_policy_name            = "CORS-and-SecurityHeadersPolicy"
          use_aws_managed_response_headers_policy = true
        },
        viewer_certificate = {
          cloudfront_default_certificate = false // false :  It will create ACM certificate with details provided in acm_details
          minimum_protocol_version       = "TLSv1.2_2021"
          ssl_support_method             = "sni-only"
        },

        acm_details = {
          domain_name               = "sf.divyasf.sourcef.us",
          subject_alternative_names = ["sf.divyasf.sourcef.us"]
        },
        custom_error_responses = [{
          error_caching_min_ttl = 300,
          error_code            = "403",
          response_code         = "200",
          response_page_path    = "/index.html"
          },
          {
            error_caching_min_ttl = 10,
            error_code            = "404",
            response_code         = "200",
            response_page_path    = "/index.html"
        }],

        price_class = "PriceClass_All"


      },
    ]
  }
}