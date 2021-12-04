# Azure Policy Deployments

This examples folder demonstrates an effective deployment of Azure Policy Definitions and Assignments. The order of execution is generally from `definitions.tf` -> `initiatives.tf` -> `assignments_<scope>.tf` -> `exemptions.tf`

> `built-in.tf` demonstrates use with Built-In definitions.