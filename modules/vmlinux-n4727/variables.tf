variable "humber_id" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "subnet_id" { type = string }
variable "storage_account_uri" { type = string }
variable "admin_username" { type = string }
variable "admin_password" { type = string }
variable "tags" { type = map(string) }

variable "vms" {
  type = map(object({
    zone = string
  }))
  default = {
    vm1 = { zone = "3" }
    vm2 = { zone = "3" }
    vm3 = { zone = "3" }
  }
}
