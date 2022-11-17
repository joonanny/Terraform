resource "azurerm_virtual_network" "user-vnet" {
  name                = var.user_vnet_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.user_vnet_spacer]
}