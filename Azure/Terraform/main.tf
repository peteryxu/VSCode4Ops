# this is an example of a basic terraform configuration
# syntax highlighting provided by HashiCorp Terraform

# configue the Azure Provider
provider "azurerm" {
    features {}
}

# Create a resoruce group
resource "azurerm_resource_group"{
    name = "demo_rg"
    location = "East US 2"
    tags = { enviroment = "demo", build = "0.1"}

}