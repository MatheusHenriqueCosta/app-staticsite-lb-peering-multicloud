resource "azurerm_resource_group" "rg" {
    name     = "rg-staticsitelbpeering"
    location = "canadacentral"
}

resource "azurerm_public_ip" "lb" {
    name                = "lb"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    domain_name_label   = "staticsitelbtf0001-matheusg"
}

resource "azurerm_lb" "lb" {
    name                = "lb"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    frontend_ip_configuration {
        name                 = "lb"
        public_ip_address_id = azurerm_public_ip.lb.id
    }
}

resource "azurerm_lb_backend_address_pool" "lb" {
    name            = "lb"
    loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_rule" "lb" {
    name                           = "HTTP"
    loadbalancer_id                = azurerm_lb.lb.id
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "lb"
    backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb.id]
}

resource "azurerm_network_interface_backend_address_pool_association" "vm01" {
    ip_configuration_name   = "vm01"
    network_interface_id    = azurerm_network_interface.vm01_nic_public.id
    backend_address_pool_id = azurerm_lb_backend_address_pool.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "vm02" {
    ip_configuration_name   = "vm02"
    network_interface_id    = azurerm_network_interface.vm02_nic_public.id
    backend_address_pool_id = azurerm_lb_backend_address_pool.lb.id
}