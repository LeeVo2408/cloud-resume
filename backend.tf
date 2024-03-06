provider "aws" {
  region = "ap-southeast-2"

}

terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

  }

  backend "s3" {
    bucket  = "cloud-resume-challenge.state"
    key     = "terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
  }

}