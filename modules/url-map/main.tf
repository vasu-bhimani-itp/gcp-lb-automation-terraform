
locals {
  optional_backends = {
    for k, v in {
      backend_a = {
        service_name = var.backend_a_service_name
        path_prefix  = var.backend_a_path_prefix
      }
      backend_b = {
        service_name = var.backend_b_service_name
        path_prefix  = var.backend_b_path_prefix
      }
    } : k => v if v.service_name != "" && v.path_prefix != ""
  }

  has_path_rules = length(local.optional_backends) > 0
}


data "google_compute_backend_service" "default" {
  project = var.project_id
  name    = var.default_backend_service_name
}

data "google_compute_backend_service" "optional" {
  for_each = local.optional_backends
  project  = var.project_id
  name     = each.value.service_name
}



resource "google_compute_url_map" "this" {
  project         = var.project_id
  name            = "${var.lb_name}-url-map"
  description     = "URL map for ${var.lb_name} External Application Load Balancer"
  default_service = data.google_compute_backend_service.default.id

  dynamic "host_rule" {
    for_each = local.has_path_rules ? [1] : []
    content {
      hosts        = ["*"]
      path_matcher = "${var.lb_name}-path-matcher"
    }
  }

  dynamic "path_matcher" {
    for_each = local.has_path_rules ? [1] : []
    content {
      name            = "${var.lb_name}-path-matcher"
      default_service = data.google_compute_backend_service.default.id

      dynamic "path_rule" {
        for_each = local.optional_backends
        content {
          paths   = ["${path_rule.value.path_prefix}", "${path_rule.value.path_prefix}/*"]
          service = data.google_compute_backend_service.optional[path_rule.key].id
        }
      }
    }
  }
}
