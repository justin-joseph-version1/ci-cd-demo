terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  backend "s3" {
    bucket = "jj-my-ci-cd-github-demo"
    key    = "terraform/ci-cd-demo/tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
#
}