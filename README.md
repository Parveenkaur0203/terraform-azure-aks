# Terraform Module: Azure Kubernetes Service (AKS)

This Terraform module provisions an **Azure Kubernetes Service (AKS)** cluster with a **user-assigned identity (UAMI)** for the control plane and optional support for the Key Vault Secrets Provider. 

---

## Table of Contents

- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Providers](#providers)
- [Requirements](#requirements)
- [Notes](#notes)

---

## Usage

You can use the module to provision an AKS cluster with a user-assigned identity and optional Key Vault Secrets Provider. Here's an example:

```hcl
module "aks" {
  source                        = "./path-to-module" # Replace with the path or GitHub link to the module
  aks_name                      = "myAKSCluster"
  location                      = "eastus"
  resource_group_name           = "myResourceGroup"
  key_vault_secrets_provider_enabled = true          # Set to true to enable Key Vault integration
}

output "kube_config_raw" {
  value = module.aks.kube_config
}

output "node_resource_group" {
  value = module.aks.node_resource_group
}
```

Example Outputs:

Once the module provisions the AKS cluster, it provides several outputs, including:

Kube Config: Raw Kubernetes configuration for your cluster.
Node Resource Group: Name of the resource group where worker node resources are managed.
User-Assigned Identity ID: The principal ID of the assigned identity.

## Inputs

| Name | Description | Type | Default | Required |
| :-- | :-- | :-- | :-- | :-- |
| aks_name | The name of the Kubernetes cluster. Must be unique within your Azure subscription. | string | n/a | Yes |
| resource_group_name | The name of the resource group for the AKS cluster. | string | n/a | Yes |
| location | The Azure region where the AKS cluster will be provisioned. | string | n/a | Yes |
| key_vault_secrets_provider_enabled | Whether to enable the Key Vault Secrets Provider integration with AKS. | bool | false | No |

## Outputs

| Name | Description |
| :-- | :-- |
| id | The resource ID of the AKS cluster. |
| kube_config | Raw Kubernetes configuration for the AKS cluster (kube_config_raw). |
| node_resource_group | The name of the resource group containing the cluster's virtual machine resources. |
| client_key | The client private key used for accessing the Kubernetes cluster. |
| client_certificate | The client certificate used for accessing the Kubernetes cluster. |
| cluster_ca_certificate | The certificate authority's certificate used for securing the cluster. |
| host | The hostname of the Kubernetes API server. |
| principal_object_id | The object ID of the AKS cluster's kubelet identity (used for authentication). |
| uami_id | The principal ID of the user-assigned identity associated with the AKS control plane. |

## Providers

This module requires the following Terraform provider:

azurerm (Azure Resource Manager): Ensure you use the latest compatible version of the provider. Learn more about the provider here.

## Requirements

Terraform CLI version >= 1.0
Azure CLI installed (if using local authentication)
Azure Subscription: The module provisions resources on your Azure account.

## Notes

User-Assigned Identity: This module automatically provisions a user-assigned identity for the AKS control plane. You can use this identity for managing resources such as Azure Key Vault.
Key Vault Secrets Provider: The Key Vault integration is optional and can be enabled using the key_vault_secrets_provider_enabled variable.
If enabled, secrets rotation is configured with a default interval of 5 minutes.
Cluster Configuration: The default cluster node pool uses a single VM of size Standard_D2_v2. You can modify this in the module's main.tf file.
