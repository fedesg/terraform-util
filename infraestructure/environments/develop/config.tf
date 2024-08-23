terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.60.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.4.3"
    }
  }
  required_version = "1.9.4"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}
