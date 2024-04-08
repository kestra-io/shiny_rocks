terraform {
  required_providers {
    kestra = {
      source  = "kestra-io/kestra" # namespace of Kestra provider
      version = "~> 0.13"         # version of Kestra Terraform provider, not the version of Kestra
    }
  }
}

provider "kestra" {
  url       = var.kestra_host
  username  = var.kestra_user
  password  = var.kestra_password
  tenant_id = var.kestra_tenant_id
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
  depends_on = [kestra_namespace.shiny_rocks, kestra_flow.flows]
}