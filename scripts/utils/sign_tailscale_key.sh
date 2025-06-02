#!/usr/bin/env bash
cd "$(dirname "$0")/../../ansible"

SERVER_NODE_KEY=$(jq -r '.tailscale_server_node_setup_key.value' terraform-output.json)
GATEWAY_NODE_KEY=$(jq -r '.tailscale_gateway_node_setup_key.value' terraform-output.json)

if [[ -z "$SERVER_NODE_KEY" || "$SERVER_NODE_KEY" == "null" ]]; then
  echo "ERROR: Could not find tailscale_server_node_setup_key in terraform-output.json" >&2
  exit 1
fi

if [[ -z "$GATEWAY_NODE_KEY" || "$GATEWAY_NODE_KEY" == "null" ]]; then
  echo "ERROR: Could not find tailscale_gateway_node_setup_key in terraform-output.json" >&2
  exit 1
fi

SERVER_SIGNED_KEY=$(tailscale lock sign "$SERVER_NODE_KEY")

if [[ -z "$SERVER_SIGNED_KEY" ]]; then
  echo "ERROR: Signing returned empty. Check that your local TLK is loaded." >&2
  exit 1
fi

GATEWAY_SIGNED_KEY=$(tailscale lock sign "$GATEWAY_NODE_KEY")

if [[ -z "$GATEWAY_SIGNED_KEY" ]]; then
  echo "ERROR: Signing returned empty. Check that your local TLK is loaded." >&2
  exit 1
fi

# 3. Write the signed key into a tiny JSON for Ansible
cat > signed-tailscale-keys.json <<EOF
{
    "tailscale_server_node_setup_key": "$SERVER_SIGNED_KEY",
    "tailscale_gateway_node_setup_key": "$GATEWAY_SIGNED_KEY"
}
EOF

echo "✅ Signed key written to ansible/signed-tailscale-keys.json"
