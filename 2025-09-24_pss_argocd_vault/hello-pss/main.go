package main

import (
	"os"

	"github.com/sikalabs/hello-world-server/pkg/server"
)

func main() {
	os.Setenv("TEXT", "Hello PSS!")
	server.Server()
}
