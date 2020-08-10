output "registry_login" {
  value = azurerm_container_registry.test.admin_username
}
output "registry_password" {
  value = azurerm_container_registry.test.admin_password
}
output "registry_login_server" {
  value = azurerm_container_registry.test.login_server
}
