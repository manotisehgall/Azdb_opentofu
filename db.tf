provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource-g" {
  name     = "resource"
  location = "eastus"
}

resource "azurerm_mysql_server" "ser1" {
  name                = "db-ser1"
  location            = azurerm_resource_group.resource-g.location
  resource_group_name = azurerm_resource_group.resource-g.name

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 15
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "mysql-db" {
  name                = "db"
  resource_group_name = azurerm_resource_group.resource-g.name
  server_name         = azurerm_mysql_server.ser1.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}