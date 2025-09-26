package main

import (
	"os"

	"github.com/ondrejsika/counter-frontend-go/pkg/server"
)

func main() {
	os.Setenv("FONT_COLOR", "#004996")
	server.Server()
}
