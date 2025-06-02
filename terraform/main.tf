module "tailscale" {
  source = "./tailscale"

  tailscale_api_key = var.tailscale_api_key
  tailnet           = var.tailscale_tailnet
}

module "google" {
  source = "./google"

  project_id     = var.gcp_project
  region         = var.gcp_region
  zone           = var.gcp_zone
  ssh_user       = var.ssh_user
  ssh_public_key = var.ssh_public_key
}

module "cloudflare" {
  source = "./cloudflare"

  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_zone_id   = var.cloudflare_zone_id
  gateway_ip_address   = module.google.gateway_public_ip
}
