terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "C:/Users/Kishan/.aws/credentials"
  profile                 = "default"
}

/*
# Use alias under the provider to use multiple of same provider with different profile or account
provider "aws" {
  alias                   = "Seoul"
  region                  = "ap-northeast-2"
  shared_credentials_file = "C:/Users/Kishan/.aws/credentials"
  profile                 = "OtherProfile"
}

Reference it under specific resource like below parameter
provider = "aws.Seoul" <provider>.<alias>
*/