variable servicebus_namespace_name {
    description = "The name of the service bus namespace"
    default     = "servicebus-namespace"
}

variable location {
    description = "The location/region where the service bus namespace is created"
    default     = "eastus"
}

variable resource_group_name {
    description = "The name of the resource group in which the service bus namespace is created"
    default     = "servicebus-rg"
}

variable servicebus_queue_name {
    description = "The name of the service bus queue"
    default     = "servicebus-queue"
}

variable sku {
    description = "The name of the service bus namespace SKU"
    default     = "Standard"
}
