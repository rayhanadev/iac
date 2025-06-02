output "tailscale_server_node_setup_key" {
  description = "Reusable, preauthorized tailnet key for any new server node."
  value       = tailscale_tailnet_key.iac_server_node_setup_key.key
  sensitive   = true
}

output "tailscale_gateway_node_setup_key" {
  description = "Reusable, preauthorized tailnet key for the gateway node."
  value       = tailscale_tailnet_key.iac_gateway_node_setup_key.key
  sensitive   = true
}
