variable "aws_region" {
  description = "AWS region"
  type        = string
}
 
variable "ec2_instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.small"
}

variable "username" {
  description = "The username for the DB master user"
  type        = string
}
variable "password" {
  description = "The password for the DB master user"
  type        = string
}

#Define variables for AWS access key, secret key, and region
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

/*
To do the same, run the below commands in the terminal with appropriate values.
export TF_VAR_aws_access_key=<access_key_value>
export TF_VAR_aws_secret_key=<secret_key_value>
export TF_VAR_aws_region=<region>                               
export TF_VAR_username=<username_value>     
export TF_VAR_password=<password_value>

*/