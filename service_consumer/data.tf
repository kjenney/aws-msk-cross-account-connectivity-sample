// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

data "aws_ami" "default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-2.0.2022*"]
  }
}

data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "service_provider" {
  backend     = "s3"
  config      = {
    bucket    = var.state_bucket
    role_arn  = var.role_in_service_provider_account
    key       = "terraform.state"
    #region    = "us-east-1"
  }
}
