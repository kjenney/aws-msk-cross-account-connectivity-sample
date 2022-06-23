resource "aws_iam_instance_profile" "msk_client_profile" {
  name = "test_profile"
  role = aws_iam_role.msk_client_role.name
}

resource "aws_iam_role" "msk_client_role" {
  name = "msk_client_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "msk_client_policy" {
  name        = "msk_client_policy"
  description = "MSK Client Policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetParameter",
        "ssm:PutParameter",
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.msk_client_role.name
  policy_arn = aws_iam_policy.msk_client_policy.arn
}
