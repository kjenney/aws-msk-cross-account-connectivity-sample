resource "aws_s3_bucket" "log-bucket" {
  bucket = "my-tf-test-bucket.kenjenney.com"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.log-bucket.id
  acl    = "private"
}
