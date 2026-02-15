variable "resource_group_name" {
  description = "Bob test name of the resource group" 
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralus"
}

variable "static_web_app_name" {
  description = "Name of the static web app"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for Static Web App"
  type        = string
  default     = "Free"
}

variable "sku_size" {
  description = "SKU size for Static Web App"
  type        = string
  default     = "Free"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

