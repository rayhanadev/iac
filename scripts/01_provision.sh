#!/bin/bash
cd "$(dirname "$0")/../terraform"

terraform init
terraform apply -auto-approve
terraform output -json > ../ansible/terraform-output.json
