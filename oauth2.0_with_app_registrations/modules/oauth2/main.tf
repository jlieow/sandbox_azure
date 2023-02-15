resource "random_uuid" "test_oauth2_permission_scope_id" {}

resource "azuread_application" "server" {
  display_name = "test-server"
  identifier_uris = [
    "api://example-app", 
  ] # Application ID URI

  api {
    requested_access_token_version = 2

    oauth2_permission_scope {
      value = var.apim_oauth2_scope
      admin_consent_description = "Allow API Invoke"
      admin_consent_display_name = "Allow API Invoke"
      id = random_uuid.test_oauth2_permission_scope_id.result
    }
  }
}

resource "azuread_application" "client" {
  display_name = "test-client"

  api {
    requested_access_token_version = 2
  }

  required_resource_access {
    resource_app_id = azuread_application.server.application_id

    resource_access {
      id = random_uuid.test_oauth2_permission_scope_id.result
      type = "Scope"
    }
  }

  web {
    redirect_uris = [ "https://oauth.pstmn.io/v1/callback" ]
  }
}

resource "azuread_application_pre_authorized" "client" {
  application_object_id = azuread_application.server.id
  authorized_app_id = azuread_application.client.application_id
  permission_ids = [ random_uuid.test_oauth2_permission_scope_id.result ]
}

data "azurerm_api_management" "get_apim" {
  name = "jerome-test-apim"
  resource_group_name = "jerome-test-env"
}

# resource "azurerm_api_management" "apim" {
#   name                = "example-apim"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   publisher_name      = "My Company"
#   publisher_email     = "company@terraform.io"

#   sku_name = "Consumption"
# }

resource "azurerm_api_management_authorization_server" "authorization_server" {
  api_management_name = data.azurerm_api_management.get_apim.name
  resource_group_name = data.azurerm_api_management.get_apim.resource_group_name

  name = "test"
  display_name = "test"
  
  client_registration_endpoint = "https://localhost"
  grant_types = [ 
    "authorizationCode", 
  ]
  authorization_endpoint = "https://login.microsoftonline.com/482e292f-548d-4e7d-b44c-1cdb1a86cb49/oauth2/v2.0/authorize"
  authorization_methods = [ 
    "GET",
  ]
  token_endpoint = "https://login.microsoftonline.com/482e292f-548d-4e7d-b44c-1cdb1a86cb49/oauth2/v2.0/token"

  client_authentication_method = [ 
    "Body", 
  ]

  bearer_token_sending_methods = [
    "authorizationHeader",
  ]

  default_scope = "${tolist(azuread_application.server.identifier_uris)[0]}/${var.apim_oauth2_scope}"
  client_id = azuread_application.client.application_id
  client_secret = "secret_in_place"
}

data "azuread_application" "server" {
  application_id = azuread_application.server.application_id
}