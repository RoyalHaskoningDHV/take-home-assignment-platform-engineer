resource "azurerm_application_insights" "test" {
  name                = "${var.tags.Name}-${var.tags.Env}-ai"
  location            = var.region
  resource_group_name = azurerm_resource_group.test.name
  application_type    = "web"
  tags                = var.tags
}
