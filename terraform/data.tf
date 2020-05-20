data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "go-note-api" {
  bucket = "go-note-api"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket" {
  value = data.aws_s3_bucket.go-note-api.bucket
}
