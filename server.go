package main

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func createServer() *echo.Echo {
	e := echo.New()
	e.Use(middleware.CORS())
	e.GET("/note", func(c echo.Context) error {
		return c.NoContent(http.StatusOK)
	})

	e.POST("/note/:user", func(c echo.Context) error {
		user := c.Param("user")
		body := new(note)
		if err := c.Bind(body); err != nil {
			return err
		}

		note, err := createNote(user, *body)
		if err != nil {
			c.Error(err)
		}

		return c.JSON(http.StatusCreated, note)
	})

	return e
}
