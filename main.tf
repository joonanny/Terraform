module "rg" {
  source = "./rg"

  rg_name = "SkyVe"
  rg_location = "koreacentral"
}

module "admin" {
  source = "./administrator"
#-------------------- Bastion vnet--------------------
  rg_name = module.rg.rg_name
  rg_location = module.rg.rg_lacation
  admin_vnet_name = "SkyVe-bastion"
  admin_vnet_spacer = "10.0.0.0/16"
#-------------------- Bastion subnet--------------------
  bastion_subnet_name = "Public-subnet"
  bastion_subnet_addr = "10.0.0.0/24"
#-------------------- management subnet--------------------
  management_subnet_name = "Private-subnet"
  management_subnet_addr = "10.0.1.0/24"
#-------------------- Bastion subnet nic--------------------
  bastion_nic_name = "bastion"
#-------------------- Bastion public ip--------------------
  bastion_ip_sku = "Standard"
  bastion_ip_zone = ["1"]
#-------------------- Bastion vm--------------------
  bastion_vm_name = "Bastion"
  bastion_vm_size = "Standard_B2s"
  bastion_vm_username = "azureuser"
  bastion_vm_passwd = "btc2022!"  # 키 사용한다면 고쳐야 함
  bastion_vm_zone = 1
#-------------------- Bastion vm nsg--------------------
  bastion_nsg_name = "BastionNSG"
  bastion_nsg_inbound_rule1_name = "ssh"
  bastion_nsg_inbound_rule1_deet_port = "22"
#-------------------- management subnet nic--------------------
  management_nic_name = "management"
  #-------------------- Bastion vm--------------------
  management_vm_name = "management"
  management_vm_size = "Standard_B2s"
  management_vm_username = "azureuser"
  management_vm_passwd = "btc2022!"  # 키 사용한다면 고쳐야 함
  management_vm_zone = 1
#-------------------- Bastion vm nsg--------------------
  management_nsg_name = "managementNSG"
  management_nsg_inbound_rule1_name = "ssh"
  management_nsg_inbound_rule1_deet_port = "22"
}

module "user" {
  source = "./user"

#-------------------- user vnet--------------------
  rg_name = module.rg.rg_name
  rg_location = module.rg.rg_lacation
  user_vnet_name = "SkyVe-aks"
  user_vnet_spacer = "10.1.0.0/16"
#-------------------- aks subnet--------------------
  aks_subnet_name = "aks-subnet"
  user_subnet_addr = "10.1.8.0/22"
#-------------------- aks subnet nic--------------------
  aks_nic_name = "aks"
#-------------------- aks --------------------
  aks_name = "skyve"
  aks_default_node_pool_name = "user"
  aks_default_node_pool_nodeCount = 1
  aks_default_node_pool_size = "Standard_B4ms"
#-------------------- aks nodepool--------------------
  aks_add_node_pool_name = "system"
  aks_add_node_pool_size = "Standard_B4ms"
#-------------------- acr--------------------
  acr_name = "skyveacr"
  acr_sku = "Premium"
}
