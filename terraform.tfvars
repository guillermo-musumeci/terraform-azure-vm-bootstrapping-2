####################
# Common Variables #
####################
company     = "kopicloud"
app_name    = "iaas"
environment = "development"
location    = "northeurope"

##################
# Authentication #
##################
azure-subscription-id = ""
azure-client-id       = ""
azure-client-secret   = ""
azure-tenant-id       = ""

###########
# Network #
###########
network-vnet-cidr   = "10.128.0.0/16"
network-subnet-cidr = "10.128.1.0/24"

############
# Linux VM #
############
web-linux-vm-size        = "Standard_B1s"
web-linux-admin-username = "tfadmin"

##############
# Windows VM #
##############
web-windows-vm-size        = "Standard_B1s"
web-windows-admin-username = "tfadmin"
