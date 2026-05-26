###############################################################################
# GCP External Application Load Balancer – Root Module
###############################################################################

terraform {
  required_version = ">= 1.7"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {

  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

###############################################################################
# URL Map Module
###############################################################################
module "url_map" {
  source = "./modules/url-map"

  lb_name                      = var.lb_name
  project_id                   = var.project_id
  default_backend_service_name = var.default_backend_service_name
  backend_a_service_name       = var.backend_a_service_name
  backend_a_path_prefix        = var.backend_a_path_prefix
  backend_b_service_name       = var.backend_b_service_name
  backend_b_path_prefix        = var.backend_b_path_prefix
}

###############################################################################
# Load Balancer Frontend Module
###############################################################################
module "lb" {
  source = "./modules/lb"

  lb_name           = var.lb_name
  project_id        = var.project_id
  url_map_self_link = module.url_map.url_map_self_link
}
