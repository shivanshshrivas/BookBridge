terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 4.0"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  
  cloud {
    organization = "brandnewbox"
    workspaces {
      name = "BookBridge-production-cluster"
    }
  }
}

provider "digitalocean" {
  token       = var.do_token
}

provider "rancher2" {
  api_url     = "https://rancher2.brandnewops.com"
  token_key   = var.rancher_token
}

module "drydock_cluster" {
  source      = "app.terraform.io/brandnewbox/drydock-cluster/brandnewbox"
  version     = "0.15.0"

  providers = {
    digitalocean = digitalocean,
    rancher2 = rancher2
  }

  project_name = "BookBridge"
  project_description = ""
  # Get the latest/greatest version here
  # https://docs.digitalocean.com/products/kubernetes/resources/supported-releases/
  # but make sure it is compatible with Rancher:
  # https://www.suse.com/suse-rancher/support-matrix/all-supported-versions/rancher-v2-6-3/
  kubernetes_version_prefix = "1.33."
  cluster_max_nodes = 3
  # This is required for new projects. Our default is no longer accessible, so we have to configure this variable in new projects.
  do_region = "sfo3"
}
