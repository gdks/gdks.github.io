#!/bin/bash

# Initialize Vault with development secrets
echo "Initializing Vault with development secrets..."

# Wait for Vault to be ready
echo "Waiting for Vault to be ready..."
while ! curl -s http://vault:8200/v1/sys/health | grep -q '"initialized":true'; do
    echo "Vault is not ready yet, waiting..."
    sleep 1
done

# Set up Vault environment
export VAULT_ADDR=http://vault:8200
export VAULT_TOKEN=dev-only-token

# Enable KV v2 secrets engine if not already enabled
echo "Enabling KV v2 secrets engine..."
vault secrets list | grep -q "^secret/" || vault secrets enable -version=2 -path=secret kv
