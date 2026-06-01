package root

import (
	"github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/dogsay"
	"github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/example"
	"github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/hello"
	"github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/random"
	cmd_version "github.com/ondrejsikax/2026-05-31-o2-cli/internal/cmd/version"
	"github.com/ondrejsikax/2026-05-31-o2-cli/version"
	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "o2",
	Short: "O2 CLI, " + version.Version,
}

func init() {
	Cmd.AddCommand(hello.Cmd)
	Cmd.AddCommand(cmd_version.Cmd)
	Cmd.AddCommand(example.Cmd)
	Cmd.AddCommand(random.Cmd)
	Cmd.AddCommand(dogsay.Cmd)
}
