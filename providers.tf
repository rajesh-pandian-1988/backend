terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate0637"
    container_name       = "tfstate"
    key                  = "sGLOhNoHjkckpygo/AE1UrOCt8Q67H8LEx9FWO/fOW2QKSfJgLyypEjQESs03z44eUP9Oo7yEmou+AStMrc0nw=="
  }
}

provider "azurerm" {
  features {}
}
