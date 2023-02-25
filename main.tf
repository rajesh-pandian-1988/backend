resource "azurerm_resource_group" "acr_aks_rg" {
  name     = "acr-aks-rg"
  location = var.location
}

resource "azurerm_container_registry" "terraform_acr" {
  name                = "tfacr0719"
  resource_group_name = azurerm_resource_group.acr_aks_rg.name
  location            = azurerm_resource_group.acr_aks_rg.location
  sku                 = "Basic"
}

resource "azurerm_kubernetes_cluster" "terraform_aks" {
  name                = "terraform-aks"
  location            = azurerm_resource_group.acr_aks_rg.location
  resource_group_name = azurerm_resource_group.acr_aks_rg.name
  dns_prefix          = "terraformaks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_role_assignment" "aks_rbac" {
  principal_id                     = azurerm_kubernetes_cluster.terraform_aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.terraform_acr.id
  skip_service_principal_aad_check = true
}
