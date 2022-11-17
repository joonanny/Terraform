#-------------------- user vnet--------------------
variable "rg_name" {
    type = string
}

variable "rg_location" {
    type = string
}

variable "user_vnet_name" {
    type = string
}

variable "user_vnet_spacer" {
    type = string
}

#-------------------- aks subnet--------------------
variable "aks_subnet_name" {
    type = string
}

variable "user_subnet_addr" {
    type = string
}

#-------------------- aks subnet nic--------------------
variable "aks_nic_name" {
    type = string
}

#-------------------- aks --------------------
variable "aks_name" {
    type = string
}

variable "aks_default_node_pool_name" {
    type = string
}

variable "aks_default_node_pool_nodeCount" {
    type = number
}

variable "aks_default_node_pool_size" {
    type = string
}

#-------------------- aks nodepool--------------------
variable "aks_add_node_pool_name" {
    type = string
}

variable "aks_add_node_pool_size" {
    type = string
}

#-------------------- acr--------------------
variable "acr_name" {
    type = string
}

variable "acr_sku" {
    type = string
}
