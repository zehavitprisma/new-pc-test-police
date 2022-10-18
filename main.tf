provider "aws" {
  region  = "us-east-1"
  profile = "dev2"
  alias = "us-east-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "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"
}

#locals {
#  inbound_ports  = [80, 443]
#  outbound_ports = [443, 1433]
#}
#
## Security Groups
#resource "aws_security_group" "list_example" {
#  vpc_id      = aws_vpc.vpc.id
#  name        = "list-example"
#
#  dynamic "ingress" {
#    for_each = local.inbound_ports
#    content {
#      from_port   = ingress.value
#      to_port     = ingress.value
#      protocol    = "tcp"
#      cidr_blocks = ["0.0.0.0/0"]
#    }
#  }
#
#  dynamic "egress" {
#    for_each = local.outbound_ports
#    content {
#      from_port   = egress.value
#      to_port     = egress.value
#      protocol    = "tcp"
#      cidr_blocks = [var.vpc-cidr]
#    }
#  }
#}

#locals {
#  ingress_rules = {
#    "https rule" = {
#      port = 443
#      cidr_blocks = ["0.0.0.0/0"],
#    }
#    "ssh rule" = {
#      port = 22
#      cidr_blocks = ["123.123.123.123/32"],
#    }
#  }
#}
#resource "aws_security_group" "map_example" {
#  vpc_id      = aws_vpc.vpc.id
#  name        = "map-example"
#
#  dynamic "ingress" {
#    for_each = local.ingress_rules
#    content {
#      description = ingress.key
#      from_port   = ingress.value.port
#      to_port     = ingress.value.port
#      protocol    = "tcp"
#      cidr_blocks = ingress.value.cidr_blocks
#    }
#  }
#}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "public-read-write"
}

module "s3_module" {
  source = "./module"

  bucket = aws_s3_bucket.example.id
}

resource "aws_s3_bucket" "example_3" {
  bucket = "example_2"

}

resource "aws_s3_bucket_public_access_block" "root" {
  bucket                  = aws_s3_bucket.root_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_ebs_volume" "v" {
  size = 40
  encrypted = false }

#resource "aws_cloudwatch_log_group" "aws_route53_example_com" {
#  provider = aws.us-east-1
#
#  name              = "/aws/route53/${aws_route53_zone.example_com.name}"
#  retention_in_days = 30
#}
#
## Example CloudWatch log resource policy to allow Route53 to write logs
## to any log group under /aws/route53/*
#
#data "aws_iam_policy_document" "route53-query-logging-policy" {
#  statement {
#    actions = [
#      "logs:CreateLogStream",
#      "logs:PutLogEvents",
#    ]
#
#    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]
#
#    principals {
#      identifiers = ["route53.amazonaws.com"]
#      type        = "Service"
#    }
#  }
#}
#
#resource "aws_cloudwatch_log_resource_policy" "route53-query-logging-policy" {
#  provider = aws.us-east-1
#
#  policy_document = data.aws_iam_policy_document.route53-query-logging-policy.json
#  policy_name     = "route53-query-logging-policy"
#}
#
## Example Route53 zone with query logging
#
#resource "aws_route53_zone" "example_com" {
#  name = "example.com"
#}
#
#resource "aws_route53_query_log" "example_com" {
#  depends_on = [aws_cloudwatch_log_resource_policy.route53-query-logging-policy]
#
#  cloudwatch_log_group_arn = aws_cloudwatch_log_group.aws_route53_example_com.arn
#  zone_id                  = aws_route53_zone.example_com.zone_id
#}

#resource "aws_iam_policy" "policy" {
#  name        = "test_policy"
#  path        = "/"
#  description = "My test policy"
#
#  # Terraform's "jsonencode" function converts a
#  # Terraform expression result to valid JSON syntax.
#  policy = {
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = [
#          "ec2:Start*",
#        ]
#        Effect   = "Allow"
#        Resource = "*"
#      },
#    ]
#  }
#  policy.Statement.*.Action
#}
