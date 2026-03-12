package main

import (
	"os"

	"github.com/ondrejsika/counter-frontend-go/pkg/server"
)

func main() {
	os.Setenv("FONT_COLOR", "blue")
	os.Setenv("BACKGROUND_COLOR", "lightblue")
	server.Server()
}
