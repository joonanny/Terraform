#-------------------- Bastion vm--------------------
resource "azurerm_linux_virtual_machine" "bastion" {
  name                = var.bastion_vm_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.bastion_vm_size
  admin_username      = var.bastion_vm_username
  admin_password      = var.bastion_vm_passwd
  #custom_data         = base64encode(file("bastion_userdata.tftpl"))
  zone                = var.bastion_vm_zone

  disable_password_authentication = false
  
  network_interface_ids = [azurerm_network_interface.bastin-nic.id]

  os_disk {
    name                 = "${var.bastion_vm_name}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
  }
}

#-------------------- Bastion vm nsg--------------------
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_sg_asso" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
}

resource "azurerm_network_security_group" "bastion_nsg" {
  name                = var.bastion_nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = var.bastion_nsg_inbound_rule1_name
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.bastion_nsg_inbound_rule1_deet_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#-------------------- management vm--------------------
resource "azurerm_linux_virtual_machine" "management" {
  name                = var.management_vm_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.management_vm_size
  admin_username      = var.management_vm_username
  admin_password      = var.management_vm_passwd
  custom_data         = base64encode(file("management_userdata.tftpl"))
  zone                = var.management_vm_zone

  disable_password_authentication = false
  
  network_interface_ids = [azurerm_network_interface.management-nic.id]

  os_disk {
    name                 = "${var.management_vm_name}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
  }
}

#-------------------- management vm nsg--------------------
resource "azurerm_subnet_network_security_group_association" "management_subnet_sg_asso" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.management_nsg.id
}

resource "azurerm_network_security_group" "management_nsg" {
  name                = var.management_nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = var.management_nsg_inbound_rule1_name
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.management_nsg_inbound_rule1_deet_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}