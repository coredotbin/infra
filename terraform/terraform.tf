terraform {
	required_providers {
		linode = {
			source = "linode/linode"
		}
	}
	required_version = ">= 1.5.1"
}

provider "linode" {
	token = var.token
}

variable "token" {}
