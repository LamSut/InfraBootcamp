#!/bin/bash

# aws iam delete-login-profile --user-name iamlim1
# aws iam delete-login-profile --user-name iamlim2

terraform init
terraform plan
terraform destroy --auto-approve