# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

provider "googleworkspace" {
  customer_id = "123244"
}

provider "random" {
  
}

locals {
  users = csvdecode(file("${path.module}/users.csv"))
}

ephemeral "random_password" "db_password" {
  length           = 16
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "googleworkspace_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  primary_email = each.value.email
  password_wo = ephemeral.random_password.db_password.result
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
