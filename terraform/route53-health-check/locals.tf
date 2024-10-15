locals {

  health_checks = {
   arc = {
    name                    = "arc-health-check"
    domain_name             = "sf.divyasf.sourcef.us"
    resource_path           = "/"
    type                    = "HTTPS"
    measure_latency         = true
    alarm_prefix            = "arc"
    failure_threshold       = 2
    request_interval        = 10
    search_string           = ""
    alarm_endpoint_protocol = "email"
    alarm_endpoint          = "arun.sai@sourcefuse.com"
    
  }, 
}
}