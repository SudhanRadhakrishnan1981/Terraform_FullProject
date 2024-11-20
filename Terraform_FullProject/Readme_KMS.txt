

AWS KMS is the key management service from Amazon that encrypts sensitive data stored in terraform config and state files. 
To implement AWS KMS in the RDS database example discussed previously, create a file with credentials as content in key-value format.

For the sake of this example, we have given it the name creds.yml.

File name creds.yml below is the values
username: username
password: password

Create a KMS key (default symmetric) in AWS, and use the below command to create an encrypted file to store and check in to VCS, 
the credentials from creds.yml.

aws kms encrypt \
--key-id <alias>OR<arn> \
--region eu-central-1 \
--plaintext fileb://creds.yml \
--output text \
--query CiphertextBlob > creds.yml.encrypted


The credentials are fetched using the data store for aws_kms_secrets as shown below. Use a local variable to decrypt
 the value from cipher text stored in creds.yml.encrypted file.

data "aws_kms_secrets" "creds" {
 secret {
   name    = "dbexample"
   payload = file("${path.module}/creds.yml.encrypted")
 }
}

locals {
 db_creds = yamldecode(data.aws_kms_secrets.creds.plaintext["dbexample"])
}

Once the secrets credentials are decrypted, use the same to set the database resource credentials as shown in the below configuration.

resource "aws_db_instance" "mydb" {
 allocated_storage    = 10
 db_name              = "mydb"
 engine               = "mysql"
 engine_version       = "5.7"
 instance_class       = "db.t3.micro"
 username             = local.db_creds.username
 password             = local.db_creds.password
 parameter_group_name = "mydb.mysql5.7"
 skip_final_snapshot  = true
}