
resource "google_compute_global_address" "this" {
  project      = var.project_id
  name         = "${var.lb_name}-ip"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}


resource "google_compute_target_http_proxy" "this" {
  project = var.project_id
  name    = "${var.lb_name}-http-proxy"
  url_map = var.url_map_self_link
}


resource "google_compute_global_forwarding_rule" "http" {
  project               = var.project_id
  name                  = "${var.lb_name}-http-fwd-rule"
  ip_address            = google_compute_global_address.this.address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.this.id

  depends_on = [google_compute_global_address.this]
}
