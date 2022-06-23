// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

locals {
  azs          = data.aws_availability_zones.available.names
  runtime_settings = jsonencode({
    log_s3_bucket              = aws_s3_bucket.log-bucket.id
    confluent_package_filename = var.confluent_package_filename
    java_version_name          = "java-1.8.0-openjdk"
    s3_endpoint_type           = "gateway"
    kafka_properties           = { "security.protocol" = "SSL" }
  })
}
