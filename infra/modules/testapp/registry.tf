resource "azurerm_container_registry" "test" {
  name = "${var.tags.Name}test${var.tags.Env}"

  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  sku           = "Basic"
  admin_enabled = true
}

resource "azurerm_container_registry_webhook" "test" {
  name = "${var.tags.Name}test${var.tags.Env}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  registry_name       = azurerm_container_registry.test.name

  service_uri    = "https://${azurerm_app_service.test.site_credential[0].username}:${azurerm_app_service.test.site_credential[0].password}@${azurerm_app_service.test.name}.scm.azurewebsites.net/docker/hook"

  status         = "enabled"
  scope          = "test:*"
  actions        = ["push"]
  custom_headers = { "Content-Type" = "application/json" }
}