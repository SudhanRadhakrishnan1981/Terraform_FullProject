terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.16.0"
    }
  }
}
 
provider "aws" {
  region = var.aws_region
}
 
module "aws_web_server_vpc" {
  source = "./Modules/aws-web-server-vpc"
}
 
module "aws_web_server_instance" {
  source  ="./Modules/aws-web-server-instance"
  ec2_instance_type = var.ec2_instance_type
  vpc_id            = module.aws_web_server_vpc.vpc_id
  subnet_id         = module.aws_web_server_vpc.subnet_id
}