# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

provider "googleworkspace" {}

locals {
  users = csvdecode(file("${path.module}/users.csv"))
}

resource "googleworkspace_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  primary_email       = each.value.email
  password_wo         = each.value.password
  password_wo_version = 1
  hash_function = each.value.password_hash_function

  name {
    family_name = each.value.last_name
    given_name  = each.value.first_name
  }

  organizations {
    department = each.value.dept
    primary    = true
    title      = each.value.title
    type       = "work"
  }
  recovery_email = each.value.recovery_email
}
