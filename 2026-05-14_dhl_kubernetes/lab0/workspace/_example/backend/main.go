package main

import (
	"fmt"
	"os"

	"github.com/ondrejsika/counter/pkg/server"
	"github.com/ondrejsika/counter/version"
)

var BUILD_ID string = "1"
var GIT_BRANCH string = ""
var GIT_COMMIT string = ""

func main() {
	setDefault("EXTRA_TEXT", "DHL")
	setDefault("API_ONLY", "1")
	version.Version += getVersionSuffix()
	server.Server(server.ServerOptions{})
}

func setDefault(key, value string) {
	if os.Getenv(key) == "" {
		os.Setenv(key, value)
	}
}

func getVersionSuffix() string {
	if GIT_BRANCH != "" && GIT_COMMIT != "" {
		return fmt.Sprintf("-build-%s-%s-%s", BUILD_ID, GIT_BRANCH, GIT_COMMIT)
	}
	return fmt.Sprintf("-build-%s", BUILD_ID)
}
