terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg-n4727"
    storage_account_name = "tfstaten4727"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}
