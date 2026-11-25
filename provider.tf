
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-state-jenkins-2026-unique123"
    key          = "terraform/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }

}

provider "aws" {
  region = var.aws_region
}

