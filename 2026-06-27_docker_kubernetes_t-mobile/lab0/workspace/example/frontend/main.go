package main

import (
	"os"
	"github.com/ondrejsika/counter-frontend-go/pkg/server"
	"github.com/ondrejsika/counter-frontend-go/version"
)

func main() {
	os.Setenv("FONT_COLOR", "white")
	os.Setenv("BACKGROUND_COLOR", "#EC018D")
	version.Version = "t-mobile-v3"
	server.Server()
}
