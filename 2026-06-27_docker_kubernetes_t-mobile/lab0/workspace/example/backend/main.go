package main

import (
	"os"
	"github.com/ondrejsika/counter/pkg/server"
	"github.com/ondrejsika/counter/version"
)

func main() {
	os.Setenv("EXTRA_TEXT", "Hello T-Mobile")
	os.Setenv("API_ONLY", "1")
	version.Version = "t-mobile-v3"
	server.Server(server.ServerOptions{})
}
