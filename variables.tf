variable "aks_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "key_vault_secrets_provider_enabled" {
  type    = bool
  default = false # Change to true to enable
}
