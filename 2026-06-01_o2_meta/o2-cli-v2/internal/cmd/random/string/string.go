package randstring

import (
	"crypto/rand"
	"fmt"
	"math/big"

	"github.com/spf13/cobra"
)

const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

var FlagLength int

func init() {
	Cmd.Flags().IntVarP(&FlagLength, "length", "l", 16, "String length")
}

var Cmd = &cobra.Command{
	Use:   "string",
	Short: "Generate a random string",
	Args:  cobra.NoArgs,
	Run: func(c *cobra.Command, args []string) {
		fmt.Println(randomString(FlagLength))
	},
}

func randomString(length int) string {
	result := make([]byte, length)
	for i := range result {
		n, _ := rand.Int(rand.Reader, big.NewInt(int64(len(charset))))
		result[i] = charset[n.Int64()]
	}
	return string(result)
}
