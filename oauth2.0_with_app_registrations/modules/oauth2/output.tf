output "azuread_application" {
  value = tolist(azuread_application.server.identifier_uris)[0]
}