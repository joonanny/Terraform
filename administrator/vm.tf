#-------------------- Bastion vm--------------------
resource "azurerm_linux_virtual_machine" "bastion" {
  name                = var.bastion_vm_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.bastion_vm_size
  admin_username      = var.bastion_vm_username
  admin_password      = var.bastion_vm_passwd
  custom_data         = base64encode(file("bastion_userdata.tftpl"))
  zone                = var.bastion_vm_zone

  disable_password_authentication = false
  
  network_interface_ids = [
    azurerm_network_interface.bastin-nic.id,
  ]

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
  name                = "BastionSecurityGroup"
  location            = azurerm_resource_group.final.location
  resource_group_name = azurerm_resource_group.final.name

  security_rule {
    name                       = "ssh"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  #   security_rule {
  #   name                       = "was"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "8080"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}