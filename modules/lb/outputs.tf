output "load_balancer_ip" {
  value = google_compute_global_address.this.address
}

output "http_forwarding_rule_name" {
  value = google_compute_global_forwarding_rule.http.name
}
