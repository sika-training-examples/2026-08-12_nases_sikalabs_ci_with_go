package root

import (
	"github.com/sika-training-example/2022-04-19--heidelbergcement--hc-cli/version"
	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "hc",
	Short: "hc, " + version.Version,
}
