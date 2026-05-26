###############################################################################
# Root Variables
###############################################################################

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default = "devops-sandbox-452616"
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "lb_name" {
  description = "Base name for all load-balancer resources"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.lb_name))
    error_message = "lb_name must be lowercase, start with a letter, 3-63 characters, letters/numbers/hyphens only."
  }
}

# ── Backend Services (must already exist in GCP) ──────────────────────────────

variable "default_backend_service_name" {
  description = "Name of the existing GCP backend service that handles all unmatched traffic."
  type        = string
}

variable "backend_a_service_name" {
  description = "Name of existing backend service A (optional)."
  type        = string
  default     = ""
}

variable "backend_a_path_prefix" {
  description = "URL path prefix routing to backend A (e.g. /api). Required if backend_a_service_name is set."
  type        = string
  default     = ""
}

variable "backend_b_service_name" {
  description = "Name of existing backend service B (optional)."
  type        = string
  default     = ""
}

variable "backend_b_path_prefix" {
  description = "URL path prefix routing to backend B (e.g. /admin). Required if backend_b_service_name is set."
  type        = string
  default     = ""
}
