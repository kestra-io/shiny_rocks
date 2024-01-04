terraform {
  required_providers {
    kestra = {
      source  = "kestra-io/kestra" # namespace of Kestra provider
      version = "~> 0.13.0"         # version of Kestra Terraform provider, not the version of Kestra
    }
  }
}

provider "kestra" {
  url = "http://localhost:8080"
  username = "shiny_rocks"
  password = "ThoseShinyRocksInOurPockets"
}

resource "kestra_flow" "flows" {
  for_each  = fileset(path.module, "flows/*/*.yml")
  flow_id   = yamldecode(templatefile(each.value, {}))["id"]
  namespace = yamldecode(templatefile(each.value, {}))["namespace"]
  content   = templatefile(each.value, {})
  keep_original_source = true
}

resource "kestra_namespace_file" "scripts" {
  for_each = fileset(path.module, "scripts/**/*")
  namespace = "shiny_rocks"
  filename = "/${each.value}"
  content = file(each.value)
}