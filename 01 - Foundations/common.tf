// examples of common expressions in terraform

// Conditional Operator
locals {
  environment = terraform.workspace == "prod" ? "production" : "development"
  instance_size = var.bool ? "t2.large" : "t2.micro"
  message = var.num > 5 ? "Greater than 5" : "Less than or equal to 5"
  filtered_list = [for i in var.list: upper(i) if length(i) > 3]
}

// List Manipulation
locals {
  original_list = ["a", "b", "c"]
  duplicated_list = [for i in local.original_list: i]
  duplicated_list_with_indices = [for i, v in local.original_list: "${i}: ${v}"]
}

// List functions
locals {
  list_length = length(local.original_list)
  list_index = index(local.original_list, "b")
  list_contains = contains(local.original_liest, "a")
  list_join = join(",", local.original_list)
  list_split = split(",", local.list_join)
}

// Map Manipulation
locals {
  original_map = {
    "a" = "apple"
    "b" = "banana"
    "c" = "cherry"
  }
  duplicated_map = {for k, v in local.original_map: k => v}
  duplicated_map_with_indices = {for k, v in local.original_map: k => "${k}: ${v}"}
}

// Map functions
locals {
  map_length = length(local.original_map)
  map_keys = keys(local.original_map)
  map_values = values(local.original_map)
}
