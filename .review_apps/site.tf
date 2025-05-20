terraform {
  required_version = "~> 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }

  backend "s3" {
    bucket = "gds-forms-integration-tfstate"
    region = "eu-west-2"
    # key is set when initializing Terraform
    # e.g. `terraform init -backend-config="key=review-apps/forms-product-page/pr-123.tfstate"`
  }
}

provider "aws" {
  allowed_account_ids = ["842676007477"]
  region              = "eu-west-2"

  default_tags {
    tags = {
      Environment = "review"
      Deployment  = "github.com/alphagov/forms-product-page/.review_apps"
      PullRequest = "https://github.com/alphagov/forms-product-page/pull/${var.pull_request_number}"
    }
  }
}
