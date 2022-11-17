#-------------------- Bastion vnet--------------------
resource "azurerm_virtual_network" "admin-vnet" {
  name                = var.admin_vnet_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.admin_vnet_spacer]
}

#-------------------- Bastion subnet--------------------
resource "azurerm_subnet" "bastion" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.admin-vnet.name
  address_prefixes     = [var.bastion_subnet_addr]
}

#-------------------- management subnet--------------------
resource "azurerm_subnet" "management" {
  name                 = var.management_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.admin-vnet.name
  address_prefixes     = [var.management_subnet_addr]
}

#-------------------- Bastion subnet nic--------------------
resource "azurerm_network_interface" "bastin-nic" {
  name                = var.bastion_nic_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.bastion_nic_name}_conf"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion-ip.id
  }
}

#-------------------- Bastion public ip--------------------
resource "azurerm_public_ip" "bastion-ip" {
  name                = "${var.bastion_nic_name}_public_IP"
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = var.bastion_ip_sku
  zones               = var.bastion_ip_zone
  location            = var.rg_location
}

#-------------------- management subnet nic--------------------
resource "azurerm_network_interface" "management-nic" {
  name                = var.management_nic_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.management_nic_name}_conf"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}