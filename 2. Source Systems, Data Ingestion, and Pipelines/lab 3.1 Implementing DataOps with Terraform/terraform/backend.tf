# Configure the backend for Terraform using AWS
terraform {
  backend "s3" {
    ### START CODE HERE ### (~ 4 lines of code)
    bucket         = "de-c2w3lab1-992382718755-us-east-1-terraform-state" # The name of the S3 bucket to store the state file
    key            = "de-c2w3lab1/terraform.state" # The key in the bucket where the state file will be stored
    region         = "us-east-1" # AWS region where the S3 bucket is located
    dynamodb_table = "de-c2w3lab1-terraform-state-lock" # The name of the DynamoDB table to use for state locking
    ### END CODE HERE ###
    encrypt        = true
    
  }
}
