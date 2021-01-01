output id {
  description = "The Id of the Benchmark Definition"
  value       = azurerm_policy_set_definition.cis_benchmark.id
}

output name {
  description = "The name of the Benchmark Definition"
  value       = var.name
}

output parameters {
  description = "The combined parameters of the Benchmark Definition"
  value       = local.parameters
}

output metadata {
  description = "The metadata of the Benchmark Definition"
  value       = local.metadata
}

output initiative {
  description = "The complete CIS Benchmark Initiative resource node"
  value       = azurerm_policy_set_definition.cis_benchmark
}
