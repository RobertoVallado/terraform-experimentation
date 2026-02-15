variable "resource_group_name" {
  default = "rg-iis-lab"
}

variable "location" {
  default = "centralus"
}

variable "vm_name" {
  default = "vm-iis"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  sensitive = true
}

variable "windows_sku" {
  default = "2022-Datacenter"
}

# INPUT ON AZURE CLI
variable "my_ip" {
  description = "Your public IP"
}

variable "tags" {
  default = {
    Proprietaire = "rvallado" #Hardcoded as per Lab
    Cegep        = "Limoilou"
    Pays         = "Canada"
  }
}
