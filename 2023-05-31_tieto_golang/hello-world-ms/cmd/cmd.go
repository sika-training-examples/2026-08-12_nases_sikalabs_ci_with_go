package cmd

import (
	"github.com/spf13/cobra"
	_ "gitlab.sikalabs.com/golang-training-brno/hello-world-ms/cmd/hello"
	"gitlab.sikalabs.com/golang-training-brno/hello-world-ms/cmd/root"
)

func Execute() {
	cobra.CheckErr(root.Cmd.Execute())
}
