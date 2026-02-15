terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -------------------------
# Resource Group
# -------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# -------------------------
# Network
# -------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-iis"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-iis"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# -------------------------
# NSG (SPECIFIC IP ONLY)
# -------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-iis"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  security_rule {
    name                       = "Allow-HTTP-MyIP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = var.my_ip
    destination_port_range     = "80"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-RDP-MyIP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = var.my_ip
    destination_port_range     = "3389"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }
}

# -------------------------
# NIC
# -------------------------
resource "azurerm_network_interface" "nic" {
  name                = "nic-iis"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# -------------------------
# VM
# -------------------------
resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 127 # OS disk size for Windows VMs
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows_sku
    version   = "latest"
  }

  tags = var.tags
}

# -------------------------
# 50GB DATA DISK
# -------------------------
resource "azurerm_managed_disk" "disk2" {
  name                 = "disk2"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 50
  create_option        = "Empty"
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  managed_disk_id    = azurerm_managed_disk.disk2.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = 0
  caching            = "ReadWrite"
}

# -------------------------
# IIS + Hello World + Defender
# -------------------------
resource "azurerm_virtual_machine_extension" "iis" {
  name                 = "iis-install"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
{
  "commandToExecute": "powershell Install-WindowsFeature Web-Server; echo 'Hello World from Azure VM' > C:\\inetpub\\wwwroot\\index.html; Set-MpPreference -DisableRealtimeMonitoring $false"
}
SETTINGS
}
