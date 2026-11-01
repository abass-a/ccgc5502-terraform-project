resource "null_resource" "display_hostnames" {
  for_each = var.vms

  triggers = {
    vm_id = azurerm_linux_virtual_machine.vm[each.key].id
  }

  provisioner "remote-exec" {
    inline = [
      "echo '=== Hostname for Linux VM ==='",
      "hostname"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.pip[each.key].ip_address
      timeout  = "3m"
    }
  }
}
