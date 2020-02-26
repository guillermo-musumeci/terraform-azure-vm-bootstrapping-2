#######################################
## Linux VM with Web Server - Output ##
#######################################

output "web_linux_vm_id" {
  description = "Virtual Machine id"
  value       = azurerm_linux_virtual_machine.web-linux-vm.id
}

output "web_linux_vm_name" {
  description = "Virtual Machine name"
  value       = azurerm_linux_virtual_machine.web-linux-vm.name
}

output "web_linux_vm_ip_address" {
  description = "Virtual Machine name IP Address"
  value       = azurerm_public_ip.web-linux-vm-ip.ip_address
}

output "web_linux_vm_admin_username" {
  description = "Username password for the Virtual Machine"
  value       = var.web-linux-admin-username
  #sensitive   = true
}

output "web_linux_vm_admin_password" {
  description = "Administrator password for the Virtual Machine"
  value       = random_password.web-linux-vm-password.result
  #sensitive   = true
}

