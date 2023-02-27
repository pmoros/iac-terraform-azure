variable resource_group_name {
    type        = string
    description = "The name of the resource group in which to create the resources."
}

variable location {
    type        = string
    description = "The Azure Region in which to create the resources."
}

variable administrator_login {
    type        = string
    description = "The administrator username of the SQL Server."
}

variable administrator_login_password {
    type        = string
    description = "The administrator password of the SQL Server."
}

variable login {
    type        = string
    description = "The login name of the user to create."
}

variable object_id {
    type        = string
    description = "The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault."
}

