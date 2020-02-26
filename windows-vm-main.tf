#######################################
## Windows VM with Web Server - Main ##
#######################################

# Generate randon name for virtual machine
resource "random_string" "random-win-vm" {
  length  = 8
  special = false
  lower   = true
  upper   = false
  number  = true
}

# Create Network Security Group to Access web VM from Internet
resource "azurerm_network_security_group" "web-windows-vm-nsg" {
  name                = "${lower(replace(var.app_name," ","-"))}-${var.environment}-web-windows-vm-nsg"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "allow-rdp"
    description                = "allow-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*" 
  }

  security_rule {
    name                       = "allow-http"
    description                = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = {
    application = var.app_name
    environment = var.environment 
  }
}

# Associate the web NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "web-windows-vm-nsg-association" {
  depends_on=[azurerm_network_security_group.web-windows-vm-nsg]

  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.web-windows-vm-nsg.id
}

# Get a Static Public IP for web
resource "azurerm_public_ip" "web-windows-vm-ip" {
  name                = "win-${random_string.random-win-vm.result}-vm-ip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Static"
  
  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Network Card for web VM
resource "azurerm_network_interface" "web-windows-vm-nic" {
  depends_on=[azurerm_public_ip.web-windows-vm-ip]

  name                      = "win-${random_string.random-win-vm.result}-vm-nic"
  location                  = azurerm_resource_group.network-rg.location
  resource_group_name       = azurerm_resource_group.network-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web-windows-vm-ip.id
  }

  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Windows web Server
resource "azurerm_windows_virtual_machine" "web-windows-vm" {
  depends_on=[azurerm_network_interface.web-windows-vm-nic]

  name                  = "win-${random_string.random-win-vm.result}-vm"
  location              = azurerm_resource_group.network-rg.location
  resource_group_name   = azurerm_resource_group.network-rg.name
  size                  = var.web-windows-vm-size
  network_interface_ids = [azurerm_network_interface.web-windows-vm-nic.id]
  
  computer_name         = "win-${random_string.random-win-vm.result}-vm"
  admin_username        = var.web-windows-admin-username
  admin_password        = var.web-windows-admin-password

  os_disk {
    name                 = "win-${random_string.random-win-vm.result}-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = {
    application = var.app_name
    environment = var.environment 
  }
}