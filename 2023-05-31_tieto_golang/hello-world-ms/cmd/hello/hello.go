package hello

import (
	"fmt"

	"github.com/spf13/cobra"
	"gitlab.sikalabs.com/golang-training-brno/hello-world-ms/cmd/root"
)

var Cmd = &cobra.Command{
	Use:   "hello",
	Short: "Say hello",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Ahoj Brno!")
	},
}

func init() {
	root.Cmd.AddCommand(Cmd)
}
