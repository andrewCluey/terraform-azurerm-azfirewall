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
  version = "1.3.2"
  
  resource_group_name = "sazfw"
  subnet_id           = data.azurerm_subnet.azure_firewall.id
  environment         = "non-prod"

    tags = {
    DeployedBy = "Terraform"
  }
}


# "git::ssh://git@ssh.dev.azure.com/v3/AzDoOrgName/projectName/terraform-azurerm-ModuleName"