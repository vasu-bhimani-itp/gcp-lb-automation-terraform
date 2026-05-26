###############################################################################
# Root Outputs
###############################################################################

output "load_balancer_ip" {
  description = "Global IPv4 address of the External Application Load Balancer."
  value       = module.lb.load_balancer_ip
}

output "url_map_name" {
  description = "Name of the URL map resource."
  value       = module.url_map.url_map_name
}

output "http_forwarding_rule_name" {
  description = "Name of the HTTP forwarding rule."
  value       = module.lb.http_forwarding_rule_name
}
