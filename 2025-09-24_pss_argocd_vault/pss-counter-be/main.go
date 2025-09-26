package main

import (
	"os"

	"github.com/ondrejsika/counter/cmd"
)

func main() {
	os.Setenv("PORT", "8000")
	os.Setenv("EXTRA_TEXT", "PSS")
	os.Setenv("BACKEND", "mongodb")
	mongodbURI := os.Getenv("MONGODB_URI")
	if mongodbURI == "" {
		mongodbURI = getMongoDBURIFromVaultOrDie(
			os.Getenv("VAULT_ADDR"),
			os.Getenv("VAULT_K8S_ROLE"),
			os.Getenv("VAULT_KV_MOUNT"),
			os.Getenv("VAULT_KV_PATH"),
			os.Getenv("VAULT_KV_KEY"),
		)
	}
	os.Setenv("MONGODB_URI", mongodbURI)
	cmd.Execute()
}
