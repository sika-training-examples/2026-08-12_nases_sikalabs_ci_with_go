package cmd

import (
	_ "github.com/sika-training-example/2022-04-19--heidelbergcement--hc-cli/cmd/hello"
	"github.com/sika-training-example/2022-04-19--heidelbergcement--hc-cli/cmd/root"
	_ "github.com/sika-training-example/2022-04-19--heidelbergcement--hc-cli/cmd/version"
	"github.com/spf13/cobra"
)

func Execute() {
	cobra.CheckErr(root.Cmd.Execute())
}
