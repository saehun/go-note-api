package main

import (
	"fmt"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
)

type Table struct {
	name string
	db   *dynamodb.DynamoDB
}

// Create session.
func (t *Table) Init(name string) {
	db := dynamodb.New(session.New(), &aws.Config{Region: aws.String("ap-northeast-2")})
	t.name = name
	t.db = db
}

// Put item into dynamodb table
func (t *Table) PutItem(item interface{}) error {

	av, err := dynamodbattribute.MarshalMap(item)
	if err != nil {
		fmt.Println("Got error marshalling attribute item:")
		fmt.Println(err.Error())
		return err
	}

	input := &dynamodb.PutItemInput{
		Item:      av,
		TableName: aws.String(t.name),
	}

	_, err = t.db.PutItem(input)
	if err != nil {
		fmt.Println("Got error PutItem:")
		fmt.Println(err.Error())
		return err
	}
	return nil
}
