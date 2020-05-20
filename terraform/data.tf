data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "go-note-api" {
  bucket = "go-note-api"
}

data "aws_route53_zone" "go-note-api" {
  name = "overthecode.io."
}

data "aws_acm_certificate" "go-note-api" {
  domain      = "overthecode.io"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
