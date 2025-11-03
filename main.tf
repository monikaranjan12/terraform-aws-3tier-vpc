terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

locals {
  project_name = "3tier-vpc"
  environment  = var.environment
  vpc_name     = "${local.project_name}-${local.environment}"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block         = var.vpc_cidr_block
  environment            = local.environment
  vpc_name               = local.vpc_name

  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  database_subnet_cidrs  = var.database_subnet_cidrs

  enable_nat_gateway     = var.enable_nat_gateway
}
