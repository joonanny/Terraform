#-------------------- user vnet--------------------
resource "azurerm_virtual_network" "user-vnet" {
  name                = var.user_vnet_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.user_vnet_spacer]
}

#-------------------- aks subnet--------------------
resource "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.user-vnet.name
  address_prefixes     = [var.user_subnet_addr]
}

#-------------------- aks subnet nic--------------------
resource "azurerm_network_interface" "aks-nic" {
  name                = var.aks_nic_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.aks_nic_name}_conf"
    subnet_id                     = azurerm_subnet.aks.id
    private_ip_address_allocation = "Dynamic"
  }
}