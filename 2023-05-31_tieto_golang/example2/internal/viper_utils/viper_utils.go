package viper_utils

import (
	"strings"

	"github.com/spf13/viper"
)

// GetInt gets a int value from Viper. Replaces dot in environment
// varible name to uderscores
func GetInt(
	// Name unsing the dot notations
	name string,
) int {
	viper.BindEnv(strings.ReplaceAll(name, ".", "_"))
	num := viper.GetInt(name)
	numEnv := viper.GetInt(strings.ReplaceAll(name, ".", "_"))
	if numEnv != 0 {
		num = numEnv
	}
	return num
}

// GetString gets a int value from Viper. Replaces dot in environment
// varible name to uderscores
func GetString(
	// Name unsing the dot notations
	name string,
) string {
	viper.BindEnv(strings.ReplaceAll(name, ".", "_"))
	str := viper.GetString(name)
	strEnv := viper.GetString(strings.ReplaceAll(name, ".", "_"))
	if strEnv != "" {
		str = strEnv
	}
	return str
}
