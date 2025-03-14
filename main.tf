resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_uami.id] # sets controlPlane UAMI
  }

  # Enable Key Vault Secrets Provider Conditionally
  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider_enabled ? [1] : []

    content {
      secret_rotation_enabled  = true
      secret_rotation_interval = "5m"
    }
  }
}

resource "azurerm_user_assigned_identity" "aks_uami" {
  location            = var.location
  name                = "${var.aks_name}-uami"
  resource_group_name = var.resource_group_name
}
