variable "location" {
  type        = string
  description = "description"
  default     = "uksouth"
}

variable "environment" {
  type        = string
  description = "description"
}

variable "resource_group_name" {
  type        = string
  description = "description"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet used for the Firewall. Must have the name ```AzureFirewallSubnet``` with a subnet mask of at least /26"
}

variable "tags" {
  type        = map(string)
  description = "description"
}

variable "additional_public_ips" {
  description = "The IDs of any additional public IP addresses that are to be assigned to the Firewall. Must be Static allocation & Standard sku."
  default     = null # Uses Azure DNS for name resolution.
}

variable "dns_servers" {
  type        = list(string)
  description = "A list of DNS servers that the Azure firewlal will direct DNS resolution requests to."
  default     = null
}

variable "azfw_policy_id" {
  type        = string
  description = "The ID of an Azure Firewall Policy to attach to the new Azure firewall instance. Optional."
  default     = null
}

