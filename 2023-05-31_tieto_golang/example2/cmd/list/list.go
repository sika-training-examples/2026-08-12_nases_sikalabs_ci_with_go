package list

import (
	"fmt"

	"github.com/golang-training-examples/example2/cmd/root"
	"github.com/golang-training-examples/example2/internal/viper_utils"
	"github.com/golang-training-examples/example2/pkg/list"
	"github.com/spf13/cobra"
)

var FlagOrigin string

var Cmd = &cobra.Command{
	Use:     "list",
	Short:   "list pets",
	Aliases: []string{"l"},
	Run: func(c *cobra.Command, args []string) {
		pets, err := list.ListPets(FlagOrigin)
		if err != nil {
			fmt.Println(err)
		}
		for _, pet := range pets {
			fmt.Printf("name=%s, age=%d, kind=%s\n", pet.Name, pet.Age, pet.Kind)
		}
	},
}

func init() {
	root.Cmd.AddCommand(Cmd)

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
