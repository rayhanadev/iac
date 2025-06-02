#!/bin/bash

./utils/sign_tailscale_key.sh

cd "$(dirname "$0")/../ansible"

ansible-playbook \
    -i inventory/hosts.yaml \
    -e "@signed-tailscale-keys.json" \
    playbooks/deploy-tailscale.yml

ansible-playbook \
    -i inventory/hosts.yaml \
    playbooks/setup-swarm.yml

ansible-playbook \
    -i inventory/hosts.yaml \
    playbooks/setup-microceph.yml
