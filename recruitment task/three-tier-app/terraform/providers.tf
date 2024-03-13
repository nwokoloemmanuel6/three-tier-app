terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.61.0"
    }
  }

  backend "s3" {
    bucket = "cloudgen-bucket-multi-layer"
    key = "infrastructure/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state_lock"
}
}



