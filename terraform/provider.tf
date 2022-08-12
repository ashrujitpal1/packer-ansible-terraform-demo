terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAWYV5RVX6Y47W5OMN"
  secret_key = "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"
}
