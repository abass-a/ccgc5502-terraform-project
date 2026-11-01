resource "azurerm_availability_set" "windows_aset" {
  name                         = "${var.humber_id}-win-aset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.tags
}

resource "azurerm_public_ip" "pip" {
  count               = var.windows_count
  name                = "${var.humber_id}-win-${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.humber_id}-win-${count.index + 1}"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.windows_count
  name                = "${var.humber_id}-win-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count                 = var.windows_count
  name                  = "${var.humber_id}-win-${count.index + 1}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_D2as_v7"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  availability_set_id   = azurerm_availability_set.windows_aset.id
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  tags                  = var.tags

  depends_on = [
    azurerm_availability_set.windows_aset,
    azurerm_network_interface.nic
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.humber_id}-win-${count.index + 1}-osdisk"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = var.windows_count
  name                       = "IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = true
  tags                       = var.tags

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": "true",
        "ScheduledScanSettings": {
            "isEnabled": "true",
            "day": "7",
            "time": "120",
            "scanType": "Quick"
        },
        "Exclusions": {
            "Extensions": "",
            "Paths": "",
            "Processes": ""
        }
    }
SETTINGS
}