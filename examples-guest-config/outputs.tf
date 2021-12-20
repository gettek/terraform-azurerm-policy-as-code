# output of the build packages script
output "cgc_definition_list" {
  value = jsondecode(data.local_file.cgc_definition_list.content)
}
