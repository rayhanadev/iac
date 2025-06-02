terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.5.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_dns_record" "root_wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*"
  content = var.gateway_ip_address
  type    = "A"
  proxied = true
  ttl     = 1
}
