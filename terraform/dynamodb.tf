resource "aws_dynamodb_table" "go-note-api" {
  name           = "go-note-api"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "user"
  range_key      = "id"

  attribute {
    name = "user"
    type = "S"
  }

  attribute {
    name = "id"
    type = "S"
  }
}
