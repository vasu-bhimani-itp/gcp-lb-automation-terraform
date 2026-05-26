variable "lb_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "default_backend_service_name" {
  type = string
}
variable "backend_a_service_name" {
  type    = string
  default = ""
}
variable "backend_a_path_prefix" {
  type    = string
  default = ""
}
variable "backend_b_service_name" {
  type    = string
  default = ""
}
variable "backend_b_path_prefix" {
  type    = string
  default = ""
}
