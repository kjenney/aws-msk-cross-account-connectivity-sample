terraform {
  backend "s3" {
    key    = "terraform.state"
    region = "us-east-1"
  }
}

