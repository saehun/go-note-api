/**
 * REST API
 */

resource "aws_api_gateway_rest_api" "go-note-api" {
  name        = "go-note-api"
}

/**
 * Deployment
 */

resource "aws_api_gateway_deployment" "go-note-api" {
  rest_api_id = aws_api_gateway_rest_api.go-note-api.id
  stage_name  = ""
}

resource "aws_api_gateway_stage" "go-note-api" {
  depends_on = [aws_api_gateway_deployment.go-note-api]

  stage_name           = "v1"
  rest_api_id          = aws_api_gateway_rest_api.go-note-api.id
  deployment_id        = aws_api_gateway_deployment.go-note-api.id
}
