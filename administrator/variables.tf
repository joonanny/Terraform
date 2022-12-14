#-------------------- Bastion vnet--------------------
variable "rg_name" {
    type = string
}

variable "rg_location" {
    type = string
}

variable "admin_vnet_name" {
    type = string
}

variable "admin_vnet_spacer" {
    type = string
}

#-------------------- Bastion subnet--------------------
variable "bastion_subnet_name" {
    type = string
}

variable "bastion_subnet_addr" {
    type = string
}

#-------------------- management subnet--------------------
variable "management_subnet_name" {
    type = string
}

variable "management_subnet_addr" {
    type = string
}

#-------------------- Bastion subnet nic--------------------
variable "bastion_nic_name" {
    type = string
}
#-------------------- Bastion public ip--------------------
variable "bastion_ip_sku" {
    type = string
}

variable "bastion_ip_zone" {
    type = list(string)
}

#-------------------- Bastion vm--------------------
variable "bastion_vm_name" {
    type = string
}

variable "bastion_vm_size" {
    type = string
}

variable "bastion_vm_username" {
    type = string
}

variable "bastion_vm_passwd" {
    type = string
}

variable "bastion_vm_zone" {
    type = number
}






