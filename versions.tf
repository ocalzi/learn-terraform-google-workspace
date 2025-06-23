# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

terraform {
#  required_version = "~> 1.0.0"
  required_providers {
    googleworkspace = {
      source = "hashicorp/googleworkspace"
#      version = "0.7.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
 }
}
