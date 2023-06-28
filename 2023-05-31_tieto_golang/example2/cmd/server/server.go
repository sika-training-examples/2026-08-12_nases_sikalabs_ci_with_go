package server

import (
	"github.com/golang-training-examples/example2/cmd/root"
	"github.com/golang-training-examples/example2/internal/viper_utils"
	"github.com/golang-training-examples/example2/pkg/server"
	"github.com/spf13/cobra"
)

var FlagPort int
var FlagPostgresDSN string

var Cmd = &cobra.Command{
	Use:     "server",
	Short:   "Run HTTP server",
	Aliases: []string{"s"},
	Run: func(c *cobra.Command, args []string) {
		server.Server(FlagPort, FlagPostgresDSN)
	},
}

func init() {
	root.Cmd.AddCommand(Cmd)

	port := viper_utils.GetInt("SERVER.PORT")
	Cmd.Flags().IntVarP(
		&FlagPort,
		"port",
		"p",
		port,
		"Listen on port",
	)
	if port == 0 {
		Cmd.MarkFlagRequired("port")
	}

	postgresDSN := viper_utils.GetString("SERVER.POSTGRES_DSN")
	Cmd.Flags().StringVar(
		&FlagPostgresDSN,
		"postgres-dsn",
		postgresDSN,
		"Postgres DSN (connection string)",
	)
	if postgresDSN == "" {
		Cmd.MarkFlagRequired("postgres-dsn")
	}
}
