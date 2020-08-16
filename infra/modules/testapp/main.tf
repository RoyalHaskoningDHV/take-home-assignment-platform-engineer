resource "azurerm_app_service_plan" "test" {
  name                = "${var.tags.Name}-${var.tags.Env}-sp"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  kind                = "linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
  tags = var.tags
}

resource "azurerm_app_service" "test" {
  name                = "${var.tags.Name}-${var.tags.Env}-as"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  app_service_plan_id = azurerm_app_service_plan.test.id

  site_config {
    always_on                 = "true"
    linux_fx_version          = "DOCKER|${azurerm_container_registry.test.login_server}/test:latest"
    use_32_bit_worker_process = "false"
  }

  app_settings = {
    "ApiConfiguration__ApiBaseUrl"                    = var.api_base_url
    "DOCKER_ENABLE_CI"                                = "true"
    "DOCKER_REGISTRY_SERVER_PASSWORD"                 = azurerm_container_registry.test.admin_password
    "DOCKER_REGISTRY_SERVER_URL"                      = azurerm_container_registry.test.login_server
    "DOCKER_REGISTRY_SERVER_USERNAME"                 = azurerm_container_registry.test.admin_username
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.test.instrumentation_key
    "WEBSITE_LOAD_CERTIFICATES"                       = "*"
    "CorsAllowedOrigins"                              = var.cors_allowed_origins
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.test.instrumentation_key
    "EventConfiguration__ConnectionString"            = "Endpoint=sb://${var.event_hub_namespace}.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=${var.event_hub_access_key};EntityPath=${var.event_hub_name}"
  }
}

resource "azurerm_eventhub_namespace" "test" {
  name                = "${var.tags.Name}-${var.tags.Env}-eventhub-namespace"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "Standard"
  capacity            = 1
  tags = var.tags
}

resource "azurerm_eventhub" "test" {
  name                = "${var.tags.Name}-${var.tags.Env}-eventhub"
  namespace_name      = azurerm_eventhub_namespace.test.name
  resource_group_name = azurerm_resource_group.test.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_consumer_group" "test" {
  name                = "test-status"
  namespace_name      = azurerm_eventhub_namespace.test.name
  eventhub_name       = azurerm_eventhub.test.name
  resource_group_name = azurerm_resource_group.test.name
}