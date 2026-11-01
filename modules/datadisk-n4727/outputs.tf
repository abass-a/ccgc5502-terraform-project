output "datadisk_names" {
  value = concat(
    [for d in azurerm_managed_disk.linux_disk : d.name],
    [azurerm_managed_disk.win_disk.name]
  )
}
