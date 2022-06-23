// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

################################################################################
# Client in remote VPC
################################################################################

resource "aws_security_group" "msk_client_remote" {
  vpc_id = module.vpc_client.vpc_id
}

resource "aws_security_group_rule" "msk_client_remote_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.msk_client_remote.id
}

resource "aws_security_group_rule" "msk_client_remote_ingress_ip" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.ip_to_connect_from]
  security_group_id = aws_security_group.msk_client_remote.id
}

resource "aws_launch_template" "msk_client_remote" {
  name          = "msk_client_remote"
  instance_type = "t3.micro"
  image_id      = data.aws_ami.default.id

  iam_instance_profile {
    arn = aws_iam_instance_profile.msk_client_profile.arn
  }

  key_name      = var.ssh_key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.msk_client_remote.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "msk_client_remote"
    }
  }
}

resource "aws_autoscaling_group" "msk_client_remote" {
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = module.vpc_client.public_subnets

  launch_template {
    id      = aws_launch_template.msk_client_remote.id
    version = "$Latest"
  }
}