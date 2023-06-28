package hello

import "fmt"

func SayHello(name string) string {
	return fmt.Sprintf("Hello %s!", name)
}

func SayAhoj(name string) string {
	return fmt.Sprintf("Ahoj %s!", name)
}

func PrintSayHello(name string) {
	fmt.Println(SayHello(name))
}
