terraform {
    cloud { 
    
    organization = "Terraforb-lab-azure" 

    workspaces { 
      name = "TerraformCI" 
    } 
  } 

  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = "3.43.0"
    }
  }
}



provider "azurerm" {
  subscription_id = "9734ed68-621d-47ed-babd-269110dbacb1"
  features {}
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length           = 20
  special          = false
  upper            = false
}

resource "azurerm_resource_group" "rg" {
  name     = "811-c71d4ef5-provide-continuous-delivery-with-gith"
  location = "westus"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


variable "ARM_SUBSCRIPTION_ID" {
  description = "Azure Subscription ID"
  type        = string
}

variable "ARM_CLIENT_ID" {
  description = "Azure Client ID"
  type        = string
}

variable "ARM_CLIENT_SECRET" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "ARM_TENANT_ID" {
  description = "Azure Tenant ID"
  type        = string
}