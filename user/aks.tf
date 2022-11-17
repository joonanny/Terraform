#-------------------- aks --------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.aks_name}dns"
  http_application_routing_enabled = "true"
  private_cluster_enabled = "true"
  # zones = [1, 2] # 클러스터 가용영역

  default_node_pool {
    name       = var.aks_default_node_pool_name
    node_count = var.aks_default_node_pool_nodeCount
    vm_size    = var.aks_default_node_pool_size
    #vnet_subnet_id = azurerm_subnet.aks.id
  }

  network_profile {
    network_plugin = "azure"
    network_mode = "transparent"
    network_policy = "azure"
    dns_service_ip = "10.1.8.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr = var.user_subnet_addr
  }

  identity {
    type = "SystemAssigned"
  }

  # depends_on = [
  #   azurerm_role_assignment.example,
  # ]

  tags = {
    Environment = "Production"
  }
}

#-------------------- aks nodepool--------------------
resource "azurerm_kubernetes_cluster_node_pool" "aksnodepool" {
  name                  = var.aks_add_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.aks_add_node_pool_size
  node_count            = 1
  #vnet_subnet_id = azurerm_subnet.aks.id

  tags = {
    Environment = "Production"
  }
}

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.yj_aks.kube_config.0.client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.yj_aks.kube_config_raw

#   sensitive = true
# }

# data "azurerm_virtual_network" "yj_aks" {
#   name                = "aks-vnet-22849829"
#   resource_group_name = "MC_final_yj_aks_koreacentral"
# }