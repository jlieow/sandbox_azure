resource "random_uuid" "test_oauth2_permission_scope_id" {}

resource "azuread_application" "server" {
  display_name = "test-server"
  identifier_uris = ["api://example-app"] # Application ID URI

  api {
    requested_access_token_version = 2

    oauth2_permission_scope {
      value = "test"
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

# data "azuread_application" "server" {
#   depends_on = [
#     azuread_application.server
#   ]
#   display_name = "test-server"
# }