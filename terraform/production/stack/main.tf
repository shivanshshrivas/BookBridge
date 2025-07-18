terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 1.0"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  
  cloud {
    organization = "brandnewbox"
    workspaces {
      name = "BookBridge-production-stack"
    }
  }
}

locals {
  rancher2_api_url = "https://rancher2.brandnewops.com"
  rancher2_default_project_id = ""
  project_name = "BookBridge"
  domains = ["BookBridge.brandnewops.com"]
}

provider "digitalocean" {
  token       = var.do_token
}

provider "rancher2" {
  api_url     = local.rancher2_api_url
  token_key   = var.rancher_token
}

module "drydock-stack" {
  source  = "app.terraform.io/brandnewbox/drydock-stack/brandnewbox"
  version = "1.0.2"

  providers = {
    digitalocean = digitalocean
    rancher2 = rancher2
  }

  do_region = "sfo3"
  project_name = local.project_name
  lb_domains = local.domains
  dns_pointed_at_lb = true
  rancher2_default_project_id = local.rancher2_default_project_id
}