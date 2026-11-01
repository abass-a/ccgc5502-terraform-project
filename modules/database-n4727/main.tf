resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = "${var.humber_id}-psql-server"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "13"
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  zone                   = "1"
  tags                   = var.tags
}
