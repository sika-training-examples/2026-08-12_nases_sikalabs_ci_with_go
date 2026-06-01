package main

import (
	"os"

	"o2-cli/internal/cmd/root"
)

func main() {
	if err := root.Cmd.Execute(); err != nil {
		os.Exit(1)
	}
}
