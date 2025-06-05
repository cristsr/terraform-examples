/**
  Inside the terraform block we can declare 
  the required version of terraform and the required providers
  
  This block is fundamental for:
  - Ensuring version compatibility
  - Specifying provider sources
  - Configuring backends for remote state
*/
terraform {
  // Minimum required version of terraform
  // This ensures a compatible version is used
  required_version = ">= 1.0"

  // Specifies required providers and their versions
  // This ensures reproducibility across different environments
  required_providers {
    aws = {
      source  = "hashicorp/aws" // Official AWS provider source
      version = "~> 5.0"        // Compatible version (5.x.x)
    }
  }
}

// Configure the AWS provider
// The provider is responsible for interacting with the AWS API
provider "aws" {
  region = "us-east-1" // Default region for all resources

  // Optional configurations for authentication
  profile                  = "mi-perfil-aws"        // AWS CLI profile
  shared_credentials_files = ["~/.aws/credentials"] // Credentials file

  // Default tags for all resources
  // These tags will be automatically applied to all created resources
  default_tags {
    tags = {
      Environment = "production" // Identifies the environment
      ManagedBy   = "terraform"  // Indicates the resource is managed by Terraform
    }
  }
}