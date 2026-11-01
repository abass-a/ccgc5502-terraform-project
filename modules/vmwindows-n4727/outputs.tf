output "windows_hostname" {
  value = azurerm_windows_virtual_machine.vm[0].name
}

output "windows_domain_name" {
  value = azurerm_public_ip.pip[0].fqdn
}

output "windows_private_ip" {
  value = azurerm_network_interface.nic[0].ip_configuration[0].private_ip_address
}

output "windows_public_ip" {
  value = azurerm_public_ip.pip[0].ip_address
}

output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.vm[0].id
}
