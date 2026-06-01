package random

import (
	"github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/random/password"
	randstring "github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/random/string"
	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "random",
	Short: "Generate random values",
}

func init() {
	Cmd.AddCommand(password.Cmd)
	Cmd.AddCommand(randstring.Cmd)
}
