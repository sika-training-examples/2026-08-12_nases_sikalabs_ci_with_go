package hello

import "testing"

func TestHello(t *testing.T) {
	msg := Hello("Dela")
	if msg != "Hello Dela!" {
		t.Fatalf(`Hello("Dela") = %s; want "Hello Dela!"`, msg)
	}
}
