ansible-playbook \
    -i inventory/hosts.yaml \
    -e "@signed-tailscale-keys.json" \
    playbooks/deploy-caddy.yaml
