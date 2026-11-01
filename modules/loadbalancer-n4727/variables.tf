variable "humber_id" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "linux_nic_ids" { type = list(string) }
variable "tags" { type = map(string) }
