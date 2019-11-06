#!/bin/bash

export VAULT_ADDR=http://0.0.0.0:8205

vault secrets enable -path=aws aws

vault write aws/config/lease lease=5m lease_max=5m

vault write aws/config/root access_key=$AWS_AK secret_key=$AWS_SC

vault write aws/roles/dev-role  credential_type=iam_user   policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt12345678910",
      "Effect": "Allow",
      "Action": [
        "S3:*",
        "iam:GetUser"

      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
