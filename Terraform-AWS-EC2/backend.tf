terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-y"
    key            = "project/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}