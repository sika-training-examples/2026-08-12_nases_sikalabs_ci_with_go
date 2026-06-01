package main

import (
	"os"

	"github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/root"
)

func main() {
	if err := root.Cmd.Execute(); err != nil {
		os.Exit(1)
	}
}
