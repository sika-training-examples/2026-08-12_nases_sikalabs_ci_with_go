package version

import (
	"fmt"

	"github.com/golang-training-examples/example2/cmd/root"
	"github.com/golang-training-examples/example2/version"
	"github.com/spf13/cobra"
)

var FlagVerbose bool

var Cmd = &cobra.Command{
	Use:     "version",
	Short:   "Get version",
	Aliases: []string{"v"},
	Run: func(c *cobra.Command, args []string) {
		if FlagVerbose {
			getVersionVerbose()
		} else {
			fmt.Println(version.Version)
		}
	},
}

func init() {
	root.Cmd.AddCommand(Cmd)
	Cmd.Flags().BoolVarP(
		&FlagVerbose,
		"verbose",
		"v",
		false,
		"Show verbose output",
	)
}

func getVersionVerbose() {
	fmt.Printf("version:    %s\n", version.Version)
	fmt.Printf("build:      %s\n", version.DateOfBuild)
	fmt.Printf("git commit: %s\n", version.GitCommit)
}
