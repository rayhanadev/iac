#!/bin/bash
cd "$(dirname "$0")/../ansible"

ansible-playbook \
    -i inventory/hosts.yaml \
    playbooks/deploy-stacks.yml
