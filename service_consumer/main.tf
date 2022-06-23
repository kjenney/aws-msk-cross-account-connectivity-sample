## Provider to build the VPC Endpoint Service so that we can set the allowed principal
provider "aws" {
  alias         = "service_provider_assume_role"
  assume_role {
    role_arn    = var.role_in_service_provider_account
  }
}

