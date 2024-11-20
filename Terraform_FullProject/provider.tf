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