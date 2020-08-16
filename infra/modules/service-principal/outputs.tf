output "client_id" {
    value = azuread_application.application.application_id
}

output "display_name" {
  value = azuread_service_principal.service_principal.display_name
}

output "client_secret" {
  value     = azuread_service_principal_password.password.value
  sensitive = true
}

output "object_id" {
  value = azuread_service_principal.service_principal.id
}