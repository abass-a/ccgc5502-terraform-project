resource "azurerm_managed_disk" "linux_disk" {
  count                = 3
  name                 = "datadisk-linux-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  zone                 = "3"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_attach" {
  count              = 3
  managed_disk_id    = azurerm_managed_disk.linux_disk[count.index].id
  virtual_machine_id = var.linux_vm_ids[count.index]
  lun                = count.index
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "win_disk" {
  name                 = "datadisk-win-1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "win_attach" {
  managed_disk_id    = azurerm_managed_disk.win_disk.id
  virtual_machine_id = var.windows_vm_id
  lun                = 0
  caching            = "ReadWrite"
}
