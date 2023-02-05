package version

import (
	"fmt"

	"github.com/sika-training-example/2022-04-19--heidelbergcement--hc-cli/cmd/root"
	"github.com/sika-training-example/2022-04-19--heidelbergcement--hc-cli/version"
	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:     "version",
	Short:   "Prints version",
	Aliases: []string{"v"},
	Args:    cobra.NoArgs,
	Run: func(c *cobra.Command, args []string) {
		fmt.Printf("%s\n", version.Version)
	},
}

func init() {
	root.Cmd.AddCommand(Cmd)
}
