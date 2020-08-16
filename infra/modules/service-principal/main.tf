data "azurerm_subscription" "current" {}

resource "random_password" "password" {
  length  = 40
  special = true
}

resource "azuread_application" "application" {
  name                       = "${var.name}-app"
  available_to_other_tenants = false
}

resource "azuread_service_principal" "service_principal" {
  application_id = azuread_application.application.application_id
}

# Setup password
resource "azuread_service_principal_password" "password" {
  service_principal_id = azuread_service_principal.service_principal.id
  value                = random_password.password.result
  end_date_relative    = var.password_end_date_relative
}

# Create role assignment for service principal
resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.scope
  role_definition_id   = azurerm_role_definition.role.id
  principal_id         = azuread_service_principal.service_principal.id
}

resource "azurerm_role_definition" "role" {
  name        = var.name
  scope       = data.azurerm_subscription.current.id
  description = "Service principal role created with terraform"

  permissions {
    actions     = [
      "Microsoft.Web/sites/read", 
      "Microsoft.Web/serverfarms/read", 
      "Microsoft.Web/sites/config/list/action",
      "Microsoft.Web/sites/config/read",
      "Microsoft.Web/sites/config/write",
      "Microsoft.Web/sites/publishxml/action"
    ]  
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id
  ]
}