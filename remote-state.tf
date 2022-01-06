terraform {
  backend "s3" {
    bucket         = "nbrown-tf-s3"
    region         = "us-west-1"
    key            = "nbrown-test-tfstate"
    dynamodb_table = "nbrown-state-lock"
  }
}
