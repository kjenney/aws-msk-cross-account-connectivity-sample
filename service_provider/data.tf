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

data "aws_msk_broker_nodes" "example" {
  cluster_arn = aws_msk_cluster.example.arn
}

data "aws_availability_zones" "available" {}