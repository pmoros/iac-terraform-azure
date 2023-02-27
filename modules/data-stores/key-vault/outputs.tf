output key_vault_id {
    value = azurerm_key_vault.kv.id
}

output tenant_id {
    value = azurerm_key_vault.kv.tenant_id
}

output object_id {
    value = data.azurerm_client_config.current.object_id
}