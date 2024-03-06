provider "aws" {
  region = "ap-southeast-2"

  default_tags {
    tags = {
      Environment = "Prod"
      Managed_by  = "https://github.com/lilyvo12/tf-aws-lilyvo-cloud-resume-challenge/"
      Project = "AWS Cloud Resume Challenge"
    }
  }
}

terraform {
  required_version = ">= 1.0.0,< 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket  = "tf-aws-lilyvo-cloud-resume-challenge-prod.state"
    key     = "terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
    dynamodb_table = "terraforn-state-lock-Cloud-Resume"
  }
}
//DynamoDB is set up mannually so even if we delete the infrastructure `, eh, too bad, we still have it in the cojso;
//DynamoDB store the state file because store locally can leads to lost of state file 
// if you have a on s3, cause confusion in the statefile
// DynamoDB prevent multiple edits on the same thing, and block the other person from pushing
