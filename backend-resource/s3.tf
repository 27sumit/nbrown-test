# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "nbrown-tf-s3" {
  bucket = "nbrown-tf-s3"

  versioning {
    enabled = true
  }

# Prevents accidental destruction
lifecycle {
prevent_destroy = true 
  }
}

