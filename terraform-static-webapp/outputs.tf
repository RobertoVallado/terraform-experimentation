output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "static_web_app_name" {
  value = azurerm_static_web_app.swa.name
}

output "static_web_app_default_hostname" {
  value = azurerm_static_web_app.swa.default_host_name
}
