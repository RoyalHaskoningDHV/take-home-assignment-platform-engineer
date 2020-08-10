resource "azurerm_resource_group" "test" {
  name     = "${var.tags.Team}-${var.tags.Name}-${var.tags.Env}-rg"
  location = var.region
  tags = var.tags
}
