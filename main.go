package main

import (
	"context"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	echoadapter "github.com/awslabs/aws-lambda-go-api-proxy/echo"
	"github.com/labstack/echo"
)

func getHandler(server *echo.Echo) func(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	echoLambda := echoadapter.New(server)
	return func(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
		// If no name is provided in the HTTP request body, throw an error
		return echoLambda.Proxy(req)
	}
}

func main() {
	server := createServer()

	env := os.Getenv("APP_ENV")
	if env == "production" {
		lambda.Start(getHandler(server))
	} else {
		server.Logger.Fatal(server.Start(":3201"))
	}
}
