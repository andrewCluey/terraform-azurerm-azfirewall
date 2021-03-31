provider "azurerm" {
  features {}
}

data "azurerm_subnet" "azure_firewall" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = "core-vnet"
  resource_group_name  = "network"
}

module "azfirewall" {
  source  = "andrewCluey/azfirewall/azurerm"
  version = "0.2.0"
  
  resource_group_name = "sazfw"
  subnet_id           = data.azurerm_subnet.azure_firewall.id
  environment         = "non-prod"

    tags = {
    DeployedBy = "Terraform"
  }
}
