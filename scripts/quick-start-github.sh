#!/bin/bash

export VAULT_ADDR=http://0.0.0.0:8200

vault auth enable github

vault policy write dev-policy dev-policy.hcl

vault write auth/github/config organization=vmwarecloudadvocacy

vault write auth/github/map/users/ishrivatsa value=dev-policy

vault audit enable file file_path=audit-creds.log
