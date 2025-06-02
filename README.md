# 🏗️ Homelab Infrastructure-as-Code (IaC)

This repository manages a fully self-hosted, GitOps-style infrastructure stack using **Terraform** for provisioning and **Ansible** for configuration and orchestration.

## Overview

### Provisioning — Terraform
- **GCP VM**: Acts as a public gateway running Caddy
- **Cloudflare**: DNS records and Zero Trust access
- **Tailscale**: Private networking and access control (ACLs)

### Configuration — Ansible
- **Docker Swarm**: Set up across 4 Raspberry Pi nodes
- **MicroCeph**: Lightweight Ceph cluster for shared block/filesystem storage
- **Caddy**: HTTPS ingress on the GCP gateway
- **Tailscale**: Installed and joined to the tailnet on all nodes
- **Stacks**: Docker Swarm apps like Uptime Kuma, Grafana, Umami, etc.

## Directory Structure

```plaintext
.
├── scripts                    # Utility scripts (provisioning, deploying, etc.)
│  ├── 01_provison.sh
│  ├── 02_configure.sh
│  ├── 03_deploy_stacks.sh
│  └── 04_deploy_caddy.sh
├── ansible                    # Configuration management
│  ├── group_vars
│  ├── inventory
│  ├── playbooks
│  ├── roles
│  │  ├── caddy
│  │  ├── docker
│  │  ├── microceph
│  │  └── stacks
└── terraform                  # Infrastructure provisioning
    ├── cloudflare
    ├── gcp
    ├── tailscale
    ├── main.tf
    └── variables.tf
````

## Prerequisites

- [Terraform v1.8+](https://developer.hashicorp.com/terraform/downloads)
- [Ansible v2.16+](https://docs.ansible.com/)

## Scripts

You can automate everything with:

```bash
scripts/01_provision.sh     # Terraform: provision infra
scripts/02_configure.sh     # Ansible: configure all nodes
scripts/03_deploy_stacks.sh # Ansible: deploy swarm stacks
scripts/04_deploy_caddy.sh  # Ansible: deploy Caddy ingress
```

## 🧹 TODO

* [ ] Add log aggregation (e.g. Loki, Promtail)
* [ ] Add automatic backups
