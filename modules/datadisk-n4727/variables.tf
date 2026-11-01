variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "linux_vm_ids" { type = list(string) }
variable "windows_vm_id" { type = string }
variable "tags" { type = map(string) }
