package main

import (
	"os"

	"github.com/sikalabs/hello-world-server/pkg/server"
)

var BUILD_ID string = "0"

func main() {
	textEnv := os.Getenv("TEXT")
	if textEnv == "" {
		server.Text += " build-" + BUILD_ID
	} else {
		os.Setenv("TEXT", textEnv+" build-"+BUILD_ID)
	}
	server.Server()
}
