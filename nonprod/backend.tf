provider "aws" {
  region = "ap-southeast-2"

  default_tags {
    tags = {
      Environment = "Non-rod"
      Managed_by  = "https://github.com/lilyvo12/tf-aws-lilyvo-cloud-resume-challenge/"
      Project = "AWS Cloud Resume Challenge"
    }
  }
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
    bucket  = "tf-aws-lilyvo-cloud-resume-challenge-nonprod.state"
    key     = "terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
    dynamodb_table = "terraforn-state-lock-Cloud-Resume"
  }

}