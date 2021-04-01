# terraform-azurerm-azfirewall

- Selecting which Azure Firewall 'SKU' you woul dlike to deploy is not yet available with this module. A future update will provide the option to deploy the Azure firewall to a virtual hub (AZFW_Hub). The default is therefore a standard vNET deployment (AZFW_VNet).
- sku_tier is not yet available in this module as the Premium tier is still in preview. Default will be to deploy a Standard tier firewall.  

## Examples
```
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
  version = "2.0.0"
  
  resource_group_name = "rg-azure-core-fw"
  subnet_id           = data.azurerm_subnet.azure_firewall.id
  environment         = "non-prod"

  additional_public_ips = [
      {
      name                  = "fw-public-ip-01"
      public_ip_address_id  = "khlgkjohk456-azure-publicIP-id"
      },
      {
      name                  = "fw-public-ip-02"
      public_ip_address_id  = "asdw2345-azure-publicIP-id"
      }
  ]

  tags = {
    DeployedBy = "Terraform"
  }

}

```


## Module Sources
# "git::ssh://git@ssh.dev.azure.com/v3/AzDoOrgName/projectName/terraform-azurerm-ModuleName"