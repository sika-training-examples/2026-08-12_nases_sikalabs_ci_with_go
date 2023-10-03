package main

import (
	_ "github.com/atotto/clipboard"
	"github.com/ondrejsika/go-hello"
	"github.com/ondrejsika/large/cmd"
)

func main() {
	hello.Hello()
	cmd.Execute()
}
