package main

import (
	"fmt"
	"os"

	"github.com/ondrejsika/counter-frontend-go/pkg/server"
	"github.com/ondrejsika/counter-frontend-go/version"
)

var BUILD_ID string = "0"

func main() {
	setDefault("FONT_COLOR", "#FFFFFF")
	setDefault("BACKGROUND_COLOR", "#05133C")
	version.Version = fmt.Sprintf("fe-build-%s", BUILD_ID)
	server.Server()
}

func setDefault(key, value string) {
	if os.Getenv(key) == "" {
		os.Setenv(key, value)
	}
}
