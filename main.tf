provider "aws" {
  region = "us-east-1-lim-1a"
}

resource "aws_iam_role" "my_role" {
  name               = "my-example-role"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_policy" "my_policy" {
  name        = "my-example-policy"
  description = "My example IAM policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "example_attach" {
  role       = aws_iam_role.my_role.name
  policy_arn = aws_iam_policy.my_policy.arn
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions   = ["s3:ListBucket", "s3:GetObject"]
    resources = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
  }
}