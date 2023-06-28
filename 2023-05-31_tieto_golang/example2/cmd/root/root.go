package root

import (
	"github.com/golang-training-examples/example2/version"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var Cmd = &cobra.Command{
	Use:   "example2",
	Short: "example2, " + version.Version,
}

func init() {
	viper.AddConfigPath("/etc/example2/")
	viper.AddConfigPath("$HOME/example2/")
	viper.AddConfigPath(".")
	viper.SetConfigName("config")
	viper.SetConfigType("yaml")
	viper.SetEnvPrefix("EXAMPLE2")
	viper.ReadInConfig()
}
