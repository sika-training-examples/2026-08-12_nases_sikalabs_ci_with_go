package main

import (
	"os"

	"github.com/ondrejsika/counter/pkg/server"
	"github.com/ondrejsika/counter/version"
)

func main() {
	os.Setenv("EXTRA_TEXT", "Hello O2")
	os.Setenv("API_ONLY", "1")
	version.Version = "o2-v5"
	server.Server(server.ServerOptions{})
}
