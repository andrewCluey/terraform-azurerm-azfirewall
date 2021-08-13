variable "location" {
  type        = string
  description = "description"
  default     = "uksouth"
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


variable "dns_servers" {
  type        = list(string)
  description = "A list of DNS servers that the Azure firewlal will direct DNS resolution requests to."
  default     = []  # Uses Azure DNS for name resolution.
}

variable "azfw_policy_id" {
  type        = string
  description = "The ID of an Azure Firewall Policy to attach to the new Azure firewall instance. Optional."
  default     = null
}

