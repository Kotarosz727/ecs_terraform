terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.1.0"
    }
  }
}
locals {
  app_name = "app:"
}
provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      application = local.app_name
    }
  }
}
