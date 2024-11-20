Let us consider an example using AWS Secrets Manager. Create a secret to store our database credentials in the AWS Secrets Manager.

In our case, we have named this secret as dbcreds. 
It is of the type “others” and stores 2 key-value pairs namely: 
db_username 
db_password.

The aws_secretsmanager_secret fetches the secrets data, but we cannot use the same to read secret values. 
To do the same,we have created another data source named aws_secretsmanager_secret_version to read the values using jsondecode() function

data "aws_secretsmanager_secret" "dbcreds" {
 name = "dbcreds"
}

data "aws_secretsmanager_secret_version" "secret_credentials" {
 secret_id = data.aws_secretsmanager_secret.dbcreds.id
}

Back into our database resource configuration, change the username and password values as shown below.

# Create an AWS DB instance resource that requires secrets
resource "aws_db_instance" "mydb" {
 allocated_storage    = 10
 db_name              = "mydb"
 engine               = "mysql"
 engine_version       = "5.7"
 instance_class       = "db.t3.micro"
 username             = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["db_username"]
 password             = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["db_password"]
 parameter_group_name = "mydb.mysql5.7"
 skip_final_snapshot  = true
}