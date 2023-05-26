package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Printf("conneting to %s %s\n", os.Getenv("DB_USER"), os.Getenv("DB_PASS"))
}
