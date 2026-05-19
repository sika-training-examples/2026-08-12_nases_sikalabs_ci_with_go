package main

import (
	"fmt"
	"os"

	"github.com/ondrejsika/counter-frontend-go/pkg/server"
	"github.com/ondrejsika/counter-frontend-go/version"
)

var BUILD_ID string = "1"
var GIT_BRANCH string = ""
var GIT_COMMIT string = ""

func main() {
	setDefault("FONT_COLOR", "#D40410")
	setDefault("BACKGROUND_COLOR", "#FFCC01")
	version.Version += getVersionSuffix()
	server.Server()
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
