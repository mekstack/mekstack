locals {
  oidc_client_id = "8113d3ec-d979-43c0-93fd-af69c7e21d6e"
}

resource "vault_jwt_auth_backend" "hse" {
  description         = "HSE Identity Provider"
  path                = "oidc"
  type                = "oidc"
  oidc_discovery_url  = "https://auth.hse.ru/adfs"
  oidc_client_id      = local.oidc_client_id
  oidc_client_secret  = "not_used"
  oidc_response_types = ["id_token"]
  oidc_response_mode  = "form_post"
  default_role        = "hse"
  tune {
    listing_visibility = "unauth"
    default_lease_ttl  = "1h"
    max_lease_ttl      = "1h"
    token_type         = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "hse" {
  backend               = vault_jwt_auth_backend.hse.path
  role_type             = "oidc"
  role_name             = "hse"
  bound_audiences       = [local.oidc_client_id]
  allowed_redirect_uris = ["https://vault.mekstack.ru/ui/vault/auth/oidc/oidc/callback"]
  user_claim            = "email"
  token_policies        = ["reader"]
  oidc_scopes           = ["openid", "email", "profile"]
}

resource "vault_identity_oidc_assignment" "hse" {
  name       = "hse"
  entity_ids = ["*"]
  group_ids  = ["*"]
}

resource "vault_identity_oidc_key" "hse" {
  name               = "hse"
  allowed_client_ids = ["*"]
  verification_ttl   = 7200
  rotation_period    = 3600
  algorithm          = "RS256"
}

// === OpenID Clients Configuration ===

resource "vault_identity_oidc_client" "keystone" {
  name             = "keystone"
  redirect_uris    = ["https://keystone.api.mekstack.ru/redirect_uri"]
  assignments      = ["allow_all"]
  key              = vault_identity_oidc_key.hse.id
  id_token_ttl     = 1800
  access_token_ttl = 3600
}

resource "vault_identity_oidc_client" "vpnaas" {
  name             = "vpnaas"
  client_type      = "public"
  redirect_uris    = ["https://vpnaas.mekstack.ru"]
  assignments      = ["allow_all"]
  key              = vault_identity_oidc_key.hse.id
  id_token_ttl     = 600
  access_token_ttl = 1200
}

// === End OpenID Clients Configuration ===

resource "vault_identity_oidc_scope" "user" {
  name = "user"
  template = base64encode(<<EOF
    {
        "username": {{ identity.entity.name }},
        "projects": {{ identity.entity.metadata.projects }}
    }
    EOF
  )
}

resource "vault_identity_oidc_provider" "hse" {
  name = "hse"
  allowed_client_ids = ["*"]
  scopes_supported = ["user"]
}

output "hse_accessor" {
  value = vault_jwt_auth_backend.hse.accessor
}
