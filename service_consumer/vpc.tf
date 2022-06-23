// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

###############################################################################
# Client VPC
###############################################################################

module "vpc_client" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "client"
  cidr                 = "10.0.0.0/16"
  enable_dns_hostnames = true

  azs            = [local.azs[0]]
  public_subnets = ["10.0.1.0/24"]
}