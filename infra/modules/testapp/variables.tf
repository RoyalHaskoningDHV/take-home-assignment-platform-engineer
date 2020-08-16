variable "tags" {
  type = map
}
variable "region" {
  default = "WestEurope"
}

variable "api_base_url" {}
variable "cors_allowed_origins" {}
variable "storage_account" {}
variable "storage_account_key" {}

variable "event_hub_namespace" {}
variable "event_hub_access_key" {}
variable "event_hub_name" {}
