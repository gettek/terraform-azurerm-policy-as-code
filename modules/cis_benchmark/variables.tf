variable management_group_name {
  type        = string
  description = "The scope at which the benchmark will be defined. Currently this must be the group_id of a management group. Changing this forces a new resource to be created"
}

variable name {
  type        = string
  description = "Benchmark name. Changing this forces a new resource to be created"
}

variable display_name {
  type        = string
  description = "Benchmark display name"
}

variable description {
  type        = string
  description = "Benchmark description"
}

variable benchmark_version {
  type        = string
  description = "Usually the git tag version for this benchmark"
  default     = "1.0.0"
}

locals {
  parameters = file("${path.module}/parameters.json")
  metadata = jsonencode(merge(
    { createdBy = data.azurerm_client_config.current.client_id },
    { category = "Regulatory Compliance" },
    { createdOn = timestamp() },
    { updatedBy = "" },
    { updatedOn = "" },
    { version = var.benchmark_version },
  ))
}

variable audit_log_analytics_workspace_retention_id {
  description = "The audit_log_analytics_workspace_retention custom policy Id to replace CISv110x5x1x2"
}
