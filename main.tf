locals {
  common_tags = {
    Project           = "CCGC 5502 Terraform Project"
    Name              = "abass.ajibola"
    ExpirationDate = "2027-12-31"
    Environment       = "Learning"
  }
}

module "rgroup" {
  source    = "./modules/rgroup-n4727"
  humber_id = var.humber_id
  location  = var.location
  tags      = local.common_tags
}

module "network" {
  source              = "./modules/network-n4727"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  tags                = local.common_tags
}

module "common" {
  source              = "./modules/common-n4727"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  tags                = local.common_tags
}

module "vmlinux" {
  source              = "./modules/vmlinux-n4727"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_primary_blob_endpoint
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = local.common_tags
}

module "vmwindows" {
  source              = "./modules/vmwindows-n4727"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_primary_blob_endpoint
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = local.common_tags
}

module "datadisk" {
  source              = "./modules/datadisk-n4727"
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  linux_vm_ids        = module.vmlinux.linux_vm_ids
  windows_vm_id       = module.vmwindows.windows_vm_id
  tags                = local.common_tags
}

module "loadbalancer" {
  source              = "./modules/loadbalancer-n4727"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  linux_nic_ids       = module.vmlinux.linux_nic_ids
  tags                = local.common_tags
}

module "database" {
  source              = "./modules/database-n4727"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = local.common_tags
}
