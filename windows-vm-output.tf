#########################################
## Windows VM with Web Server - Output ##
#########################################

# Web Windows VM ID
output "web_windows_vm_id" {
  value = azurerm_windows_virtual_machine.web-windows-vm.id
}

# Web Windows VM Name
output "web_windows_vm_name" {
  value = azurerm_windows_virtual_machine.web-windows-vm.name
}

# Web Windows VM Admin Username
output "web_windows_vm_admin_username" {
  value = var.web-windows-admin-username
}

# Web Windows VM Admin Password
output "web_windows_vm_admin_password" {
  value = var.web-windows-admin-password
}

# Web Windows VM Public IP
output "web_windows_vm_public_ip" {
  value = azurerm_public_ip.web-windows-vm-ip.ip_address
}