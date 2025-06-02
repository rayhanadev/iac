terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.20.0"
    }
  }
}

provider "tailscale" {
  api_key = var.tailscale_api_key
  tailnet = var.tailnet
}

resource "tailscale_acl" "as_json" {
  acl = jsonencode({
    "acls" : [
      {
        "action" : "accept",
        "src" : ["group:admin", "tag:server", "tag:gateway"],
        "dst" : ["tag:server:*", "tag:gateway:*"]
      },
      {
        "action" : "accept",
        "src" : ["group:family"],
        "dst" : ["100.70.0.100:*"]
      },
      {
        "action" : "accept",
        "src" : ["tag:server", "autogroup:member"],
        "dst" : ["autogroup:internet:*"]
      }
    ],
    "grants" : [
      {
        "src" : ["group:admin"],
        "dst" : ["10.10.0.0/24", "10.10.10.0/24"],
        "ip" : ["*:*"]
      }
    ],
    "ssh" : [
      {
        "action" : "accept",
        "src" : ["group:admin"],
        "dst" : ["tag:server"],
        "users" : ["autogroup:nonroot", "root", "ray"]
      }
    ],
    "nodeAttrs" : [
      {
        "target" : ["autogroup:member"],
        "attr" : ["funnel"]
      }
    ],
    "groups" : {
      "group:admin" : ["me@rayhanadev.com"],
      "group:family" : ["me@rayhanadev.com", "chrissss4156@gmail.com"]
    },
    "tagOwners" : {
      "tag:server" : ["group:admin"],
      "tag:gateway" : ["group:admin"]
    }
  })
}

resource "tailscale_tailnet_key" "iac_server_node_setup_key" {
  description   = "iac-node-setup-key"
  preauthorized = true
  reusable      = true
  tags          = ["server"]
}

resource "tailscale_tailnet_key" "iac_gateway_node_setup_key" {
  description   = "iac-gateway-setup-key"
  preauthorized = true
  reusable      = true
  tags          = ["gateway", "server"]
}
