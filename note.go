package main

import (
	"fmt"
	"strconv"
	"time"
)

var noteTable *Table

func init() {
	noteTable = &Table{}
	noteTable.Init("go-note-api")
}

type note struct {
	User      string    `json:"user"`
	Id        string    `json:"id"`
	Title     string    `json:"title"`
	Content   string    `json:"content"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type NoteKey struct {
	Id   string `json:"id"`
	User string `json:"user"`
}

func createNote(user string, m note) (*note, error) {
	fmt.Println(m)

	_m := note{
		User:      user,
		Content:   m.Content,
		Id:        strconv.FormatInt(time.Now().UTC().UnixNano()/1000, 10),
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
		Title:     m.Title,
	}

	err := noteTable.PutItem(_m)
	if err != nil {
		return nil, err
	}
	return &_m, nil
}
