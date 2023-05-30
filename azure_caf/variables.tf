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

variable "subscription_id" {
  description = "Subscription ID."
}

variable "tenant_id" {
  description = "Tenant ID."
}

## config.tfvars

variable "virtual_machines" {
  default     = {}
  description = "Create a virtual machine from CAF module"
}
variable "resource_groups" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "public_ip_addresses" {
  default = {}
}
variable "keyvaults" {
  default = {}
}
variable "global_settings" {
  default = {}
}