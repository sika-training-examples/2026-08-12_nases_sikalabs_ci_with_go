package main

import (
	priv_hello "gitlab.sikalabs.com/go/hello-from-gitlab-private"
	"gitlab.sikalabs.com/golang-training-brno/hello-world-os/hello"
)

func main() {
	priv_hello.HelloFromGitlab()
	hello.PrintSayHello("Brno")
}
