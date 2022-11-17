terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.31.0"
    }
  }
}

provider "azurerm" {
  #skip_provider_registration = "true"
  features {}
}

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
  bastion_vm_passwd = "btc2022!"  # 이거 키 사용한다면 고쳐야 함
  bastion_vm_zone = 1


}

# module "user" {
#   source = "./user"

#   rg_name = module.rg.rg_name
#   rg_location = module.rg.rg_lacation
#   user_vnet_name = "SkyVe-aks"
#   user_vnet_spacer = "10.1.0.0/16"
# }