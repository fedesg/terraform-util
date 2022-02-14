terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "cognito" {
    source = "../../../modules/congnito"

    # module parameter
    cognito_user_pool_name = "poc_user_pool"
}