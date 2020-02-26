######################################
## Windows VM with Web Server - Web ##
######################################

# Virtual Machine Extension to Install IIS
resource "azurerm_virtual_machine_extension" "iis-windows-vm-extension" {
  depends_on=[azurerm_windows_virtual_machine.web-windows-vm]

  name                 = "win-${random_string.random-win-vm.result}-vm-extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.web-windows-vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    { 
      "commandToExecute": "powershell Install-WindowsFeature -name Web-Server -IncludeManagementTools;"
    } 
  SETTINGS

  tags = {
    application = var.app_name
    environment = var.environment
  }
}
