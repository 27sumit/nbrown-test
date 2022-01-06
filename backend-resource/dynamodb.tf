resource "aws_dynamodb_table" "nbrown-terraform-state-lock" {
  name           = "nbrown-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }


# Prevents accidental destruction
lifecycle {
prevent_destroy = true
  }

  tags = {
    Name = "Nbrown Test Terraform State Lock Table"
  }
}

