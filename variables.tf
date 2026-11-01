variable "location" {
  type    = string
  default = "canadacentral"
}

variable "humber_id" {
  type    = string
  default = "n4727"
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "admin_password" {
  type      = string
  default   = "P@ssw0rd4727!A"
  sensitive = true
}
