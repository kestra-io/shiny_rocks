resource "kestra_namespace" "shiny_rocks" {
  namespace_id  = "shiny_rocks"
  description   = "Shiny Rocks"
}

resource "kestra_namespace_secret" "gcp_creds" {
  namespace    = kestra_namespace.shiny_rocks.id
  secret_key   = "GCP_CREDS"
  secret_value = file("./gcp_service_account/kestra-dev.json")
}