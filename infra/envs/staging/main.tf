terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "testtff"
    container_name       = "test"
    key                  = "staging.terraform.tfstate"
  }
}

module "test" {
  source                        = "../../modules/testapp"
  api_base_url                  = "http://localhost:8080/"
  cors_allowed_origins          = "http://localhost:*,https://localhost:*"
  storage_account               = "testtf"
  storage_account_key           = var.storage_account_key
  event_hub_namespace           = var.event_hub_namespace
  event_hub_access_key          = var.event_hub_access_key
  event_hub_name                = var.event_hub_name

  tags = {
    Env = "staging"
    Name = "test"
  }
}