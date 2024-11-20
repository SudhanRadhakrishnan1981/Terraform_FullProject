Create an RDS database instance that needs a username and password attributes to be set. Additionally, 
we also need a couple of variables for Terraform to access the AWS platform – access key, secret key, and region.

We begin by creating variables for these secrets.

variables.tf
#Define variables for secrets
variable "username" {
 type = string
}
variable "password" {
 type = string
}

#Define variables for AWS access key, secret key, and region
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

*************End file******************

Next, we set the corresponding environment variables in the format – TF_VAR_variable_name, where “variable_name” 
is the name of the input variables we defined in the previous step.

To do the same, run the below commands in the terminal with appropriate values.

export TF_VAR_aws_access_key=<access_key_value>
export TF_VAR_aws_secret_key=<secret_key_value>
export TF_VAR_aws_region=<region>                               
export TF_VAR_username=<username_value>     
export TF_VAR_password=<password_value>
Next, we will define the aws_db_instance resource in Terraform configuration that uses these secrets.

Also, note that we have defined the provider block with corresponding input variables.

provider "aws" {
 access_key = var.aws_access_key
 secret_key = var.aws_secret_key
 region     = var.aws_region
}

# Create an AWS DB instance resource that requires secrets
resource "aws_db_instance" "mydb" {
 allocated_storage    = 10
 db_name              = "mydb"
 engine               = "mysql"
 engine_version       = "5.7"
 instance_class       = "db.t3.micro"
 username             = var.username
 password             = var.password
 parameter_group_name = "mydb.mysql5.7"
 skip_final_snapshot  = true
}
Here we used environment variables to store AWS keys and accessed them using TF_VAR_ variables and similar behavior 
for the database username and password. The above Terraform code picks up the secrets automatically. 
This technique does not store secrets in plain text in the code