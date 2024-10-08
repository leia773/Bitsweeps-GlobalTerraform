terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {

    region = var.region
    shared_credentials_files = ["/your/path/to/.aws/credentials"] #["/home/nik/.aws/bitsweeps/credentials"] 
    # assume_role {
    #   role_arn = "arn:aws:iam::391728322042:user/world-Leaves-Nik"
    # }
    assume_role {
        role_arn = "arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME>"
      }
      
  
}

resource "aws_s3_bucket" "terraform_state" {
   
  bucket = var.bucket_name
  lifecycle {
    prevent_destroy = true
  }

}

# versioning enalble 

resource "aws_s3_bucket_versioning" "enabled" {

  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }

  
  
}
# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access_blocked"{
  bucket = aws_s3_bucket.terraform_state.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  
}


# Enable server-side encryption by default

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {

    bucket = aws_s3_bucket.terraform_state.id
    rule{
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }  
}


resource "aws_dynamodb_table" "terraform_state_locks" {

  name = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
   attribute {

    name = "LockID"
    type = "S"
   
    }  

  
}