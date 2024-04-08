variable "kestra_api_token" {
  type      = string
  sensitive = true
}

variable "kestra_host" {
  type      = string
  sensitive = false
  default   = "https://us.kestra.cloud"
}

variable "kestra_tenant_id" {
  type      = string
  sensitive = false
  default   = "demo"

}