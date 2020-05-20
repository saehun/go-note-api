# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=main
S3_BUCKET=go-note-api
LAMBDA_NAME=go-note-api

all: test build
build: 
	$(GOBUILD) -o $(BINARY_NAME) -v
test: 
	$(GOTEST) -v ./...
clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)

deps:
	$(GOGET) github.com/aws/aws-sdk-go
	$(GOGET) github.com/labstack/echo
	$(GOGET) github.com/aws/aws-lambda-go
	$(GOGET) github.com/awslabs/aws-lambda-go-api-proxy

# Cross compilation
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_NAME) -v

# Package
package: 
	zip lambda.zip main

# Upload compiled
deploy: package
	aws s3 cp ./lambda.zip s3://${S3_BUCKET}/${LAMBDA_NAME}/
	aws lambda update-function-code \
		--region ap-northeast-2 \
		--function-name ${LAMBDA_NAME} \
		--s3-bucket ${S3_BUCKET} \
		--s3-key ${LAMBDA_NAME}/lambda.zip --publish
