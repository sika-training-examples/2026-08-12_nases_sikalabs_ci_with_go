package hello

import (
	"fmt"

	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "hello [name]",
	Short: "Say hello",
	Args:  cobra.MaximumNArgs(1),
	Run: func(c *cobra.Command, args []string) {
		name := "O2"
		if len(args) > 0 {
			name = args[0]
		}

		hello(name)
	},
}

func hello(name string) {
	fmt.Printf("Hello %s!\n", name)
}
