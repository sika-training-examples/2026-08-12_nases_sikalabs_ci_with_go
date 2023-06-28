package main

import "fmt"

type Animal interface {
	Speak() string
}

type Dog struct{}

func (d Dog) Speak() string {
	return "Woof!"
}

type Cat struct{}

func (c Cat) Speak() string {
	return "Meow!"
}

func MakeSound(a Animal) {
	fmt.Println(a.Speak())
}

func main() {
	MakeSound(Dog{})
	MakeSound(Cat{})
}
