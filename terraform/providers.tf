terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  backend "s3" {
    bucket = "jj-my-ci-cd-demo"
    key    = "mystatefile"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = "us-east-1"
  #access_key = var.aws_access_key
  #secret_key = var.aws_secret_key
}