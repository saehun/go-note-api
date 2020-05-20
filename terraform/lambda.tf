
resource "aws_iam_role" "go-note-api" {
  name = "LambdaRole_GoNoteAPI"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {"Service": "lambda.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "go-note-api" {
  role       = aws_iam_role.go-note-api.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "go-note-api" {
  function_name = "go-note-api"
  role          = aws_iam_role.go-note-api.arn
  filename      = "../lambda.zip"
  handler       = "main"
  runtime       = "go1.x"
  memory_size   = 1024
  timeout       = 300

  environment {
    variables = {
      APP_ENV = "production"
    }
  }
}

resource "aws_cloudwatch_log_group" "go-note-api" {
  name = "/aws/lambda/go-note-api"
}
