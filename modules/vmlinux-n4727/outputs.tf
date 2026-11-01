output "linux_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.name]
}

output "linux_fqdns" {
  value = [for pip in azurerm_public_ip.pip : pip.fqdn]
}

output "linux_private_ips" {
  value = [for nic in azurerm_network_interface.nic : nic.ip_configuration[0].private_ip_address]
}

output "linux_public_ips" {
  value = [for pip in azurerm_public_ip.pip : pip.ip_address]
}

output "linux_vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.id]
}

output "linux_nic_ids" {
  value = [for nic in azurerm_network_interface.nic : nic.id]
}
