# Provide AWS Access key and Secret Key

provider "vault" {

  address = "http://0.0.0.0:8205/"
  token   = var.vault_token
}

data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "dev-role"
}

provider "aws" {
   access_key = data.vault_aws_access_credentials.creds.access_key
   secret_key = data.vault_aws_access_credentials.creds.secret_key
   region     = "us-east-1"
}

# This allows terraform to backup the *.tfstate file to AWS s3 bucket. Uncomment or Remove the lines to disable remote backup and use local state (Not Recommended)
# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key/some.tfstate"
#     region = "us-east-1"
#   }
# }
# Here it is initialized with empty parameters. Other params can be passed at "terraform init --backend-config="bucket=mybucket" --backend-config="key=path/to/my/key/some.tfstate" --backend-config="region=us-east-1""

#terraform {
#  backend "s3" {
#  }
#}

