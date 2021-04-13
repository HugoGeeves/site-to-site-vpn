provider "aws" {
    region = "eu-west-2"
}

terraform {
  backend "s3" {
      bucket = "sts-environment-state"
      key    = "state"
      region = "eu-west-2"
      dynamodb_table = "terraform-lock"
  }
}