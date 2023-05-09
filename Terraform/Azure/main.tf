# VARIABLES

# PROVIDERS
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}


# RESOURCES
# Creación de un Resource Group para todo lo que construyas 
resource "azurerm_resource_group" "vmlinuxsas" {
    name     = "vm_linux_SAS"
    location = "westeu"

    tags = {
        alummo = "SAS"
    }
}

#Creamos una Vnet y su correspondiente subnet
resource "azurerm_virtual_network" "terraformnetworksas" {
    name                = "Vnet_SAS"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.vmlinuxsas.name

    tags = {
        alummo = "SAS"
    }
}

resource "azurerm_subnet" "terraformsubnetsas" {
    name                 = "Subnet_SAS"
    resource_group_name  = azurerm_resource_group.vmlinuxsas.name
    virtual_network_name = azurerm_virtual_network.terraformnetworksas.name
    address_prefixes       = ["10.0.2.0/24"]
}

# Añadimos una IP Pública
resource "azurerm_public_ip" "terraformpublicipsas" {
    name                         = "PublicIP_SAS"
    location                     = "westeu"
    resource_group_name          = azurerm_resource_group.vmlinuxsas.name
    allocation_method            = "Dynamic"

    tags = {
        alummo = "SAS"
    }
}

# Creamos un network security Group
resource "azurerm_network_security_group" "terraformnsgsas" {
    name                = "NetworkSecurityGroup_SAS"
    location            = "westeu"
    resource_group_name = azurerm_resource_group.vmlinuxsas.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        alummo = "SAS"
    }
}

# Creamos una NIC
resource "azurerm_network_interface" "terraformnicsas" {
    name                        = "myNIC_SAS"
    location                    = "westeu"
    resource_group_name         = azurerm_resource_group.vmlinuxsas.name

    ip_configuration {
        name                          = "myNicConfigurationsas"
        subnet_id                     = azurerm_subnet.terraformsubnetsas.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.terraformpublicipsas.id
    }

    tags = {
        alummo = "SAS"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.terraformnicsas.id
    network_security_group_id = azurerm_network_security_group.terraformnsgsas.id
}

# Generamos un ID aleatorio
resource "random_id" "randomIdsas" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.vmlinuxsas.name
    }

    byte_length = 8
}

resource "azurerm_storage_account" "storageaccountsas" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.vmlinuxsas.name
    location                    = "westeu"
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        alummo = "SAS"
    }
}

# Creamos la máquina virtual, por fin 
resource "tls_private_key" "example_ssh_sas" {
  algorithm = "RSA"
  rsa_bits = 4096
}

output "tls_private_key" { value = tls_private_key.example_ssh_sas.private_key_pem }

resource "azurerm_linux_virtual_machine" "terraformvm_sas" {
    name                  = "myVM_SAS"
    location              = "westeu"
    resource_group_name   = azurerm_resource_group.vmlinuxsas.name
    network_interface_ids = [azurerm_network_interface.terraformnicsas.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisksas"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvmsas"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.example_ssh_sas.public_key_openssh
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storageaccountsas.primary_blob_endpoint
    }

    tags = {
        alummo = "SAS"
    }
}