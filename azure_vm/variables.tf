## backend.tfvars

variable "resource_group_name" {
  description = "Resource group which contains the storage account."
}

variable "storage_account_name" {
  description = "Storage account to hold the container which will hold the tf state file. ONLY USED IN backend.if"
}

variable "container_name" {
  description = "Container to hold the tf state file. ONLY USED IN backend.tf."
}

variable "key" {
  description = "Name of tf state file to be saved. ONLY USED IN backend.tf."
}

## config.tfvars

variable "subscription_id" {
  description = "Subscription ID."
}

variable "tenant_id" {
  description = "Tenant ID."
}