package password

import (
	"crypto/rand"
	"fmt"
	"math/big"
	"strings"

	"github.com/spf13/cobra"
)

const (
	lowerChars   = "abcdefghijklmnopqrstuvwxyz"
	upperChars   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	digitChars   = "0123456789"
	allChars = lowerChars + upperChars + digitChars
)

var Cmd = &cobra.Command{
	Use:   "password",
	Short: "Generate a random password (4 sections of 4 chars joined by _)",
	Args:  cobra.NoArgs,
	Run: func(c *cobra.Command, args []string) {
		fmt.Println(password())
	},
}

func randChar(charset string) byte {
	n, _ := rand.Int(rand.Reader, big.NewInt(int64(len(charset))))
	return charset[n.Int64()]
}

func password() string {
	chars := make([]byte, 16)
	chars[0] = randChar(lowerChars)
	chars[1] = randChar(upperChars)
	chars[2] = randChar(digitChars)
	for i := 3; i < 16; i++ {
		chars[i] = randChar(allChars)
	}
	// shuffle
	for i := len(chars) - 1; i > 0; i-- {
		j, _ := rand.Int(rand.Reader, big.NewInt(int64(i+1)))
		chars[i], chars[j.Int64()] = chars[j.Int64()], chars[i]
	}
	sections := make([]string, 4)
	for i := range sections {
		sections[i] = string(chars[i*4 : i*4+4])
	}
	return strings.Join(sections, "_")
}
