package dogsay

import (
	"strings"

	"github.com/sikalabs/dogsay/pkg/dogsay"
	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "dogsay <text...>",
	Short: "Dog say something",
	Args:  cobra.MinimumNArgs(1),
	Run: func(c *cobra.Command, args []string) {
		dogsay.PrintDogSay(strings.Join(args, " "))
	},
}
