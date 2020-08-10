terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "testtf"
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
  tags = {
    Env = "staging"
    Name = "test"
  }
}