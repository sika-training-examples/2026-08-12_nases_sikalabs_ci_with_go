package create

import (
	"github.com/golang-training-examples/example2/cmd/root"
	"github.com/golang-training-examples/example2/internal/viper_utils"
	"github.com/golang-training-examples/example2/pkg/create"
	"github.com/spf13/cobra"
)

var FlagName string
var FlagAge int
var FlagKind string
var FlagOrigin string

var Cmd = &cobra.Command{
	Use:     "create",
	Short:   "Create pet",
	Aliases: []string{"c"},
	Run: func(c *cobra.Command, args []string) {
		create.CreatePet(FlagOrigin, FlagName, FlagAge, FlagKind)
	},
}

func init() {
	root.Cmd.AddCommand(Cmd)
	Cmd.Flags().StringVarP(
		&FlagName,
		"name",
		"n",
		"",
		"Name of the pet",
	)
	Cmd.MarkFlagRequired("name")
	Cmd.Flags().IntVarP(
		&FlagAge,
		"age",
		"a",
		0,
		"Age of the pet",
	)
	Cmd.MarkFlagRequired("age")
	Cmd.Flags().StringVarP(
		&FlagKind,
		"kind",
		"k",
		"",
		"Kind of the pet",
	)
	Cmd.MarkFlagRequired("kind")

	origin := viper_utils.GetString("CLIENT.ORIGIN")

	Cmd.Flags().StringVar(
		&FlagOrigin,
		"origin",
		origin,
		"Connect to server on origin",
	)
	if origin == "" {
		Cmd.MarkFlagRequired("origin")
	}
}
