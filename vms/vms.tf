resource "azurerm_resource_group" "example" {
  name     = "linh-resources"
  location = "Korea Central"
}

resource "azurerm_virtual_network" "main" {
  name                = "linh-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
    for_each = var.vms
    name                = each.value.nic.name
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    # private_ip_address_version = 
    # private_ip_address
    # public_ip_address_id
    # primary
  }
  # enable_accelerated_networking
  # tags
}

resource "azurerm_virtual_machine" "main" {
    for_each = var.vms
    name                  = each.key
    location              = azurerm_resource_group.example.location
    resource_group_name   = azurerm_resource_group.example.name
    network_interface_ids = [azurerm_network_interface.main[each.key].id]
    vm_size               = each.value.size
    zones = each.value.zone
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = each.value.tags
}