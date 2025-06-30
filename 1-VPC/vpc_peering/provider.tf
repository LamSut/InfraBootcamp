terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.reg_a, aws.reg_b]
    }
  }
}
