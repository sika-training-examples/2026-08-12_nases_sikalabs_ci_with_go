package hello_test

import (
	"testing"

	"gitlab.sikalabs.com/golang-training-brno/hello-world-os/hello"
)

func TestSayHello(t *testing.T) {
	got := hello.SayHello("Dela")
	want := "Hello Dela!"
	if got != want {
		t.Errorf(`SayHello("Dela") == "%s"; want "%s"`, got, want)
	}
}

func TestPrintSayHello(t *testing.T) {
	hello.PrintSayHello("Dela")
}
