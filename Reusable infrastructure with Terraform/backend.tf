terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "my-lock-table"
  }
}
