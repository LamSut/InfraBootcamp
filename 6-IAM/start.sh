#!/bin/bash

terraform init
terraform plan
terraform apply --auto-approve | tee terraform-output.txt

# aws iam create-login-profile --user-name iamlim1 --password 'IAMLim@1' 
# aws iam create-login-profile --user-name iamlim1 --password 'IAMLim@2'

