package main

import "fmt"

type Animal interface {
	Speak() string
}

type Pet interface {
	Animal
	GetName() string
}

type Dog struct {
	Name string
}

func (d Dog) GetName() string {
	return d.Name
}

func (d Dog) Speak() string {
	return fmt.Sprintf("Woof, I'm %s!", d.Name)
}

type Cat struct{}

func (c Cat) Speak() string {
	return "Meow!"
}

type Fish struct{}

type Komodo struct {
	Name string
}

func (k Komodo) GetName() string {
	return k.Name
}

func MakeSound(a Animal) {
	fmt.Println(a.Speak())
}

func WhoAreU(p Pet) {
	fmt.Println("I'm", p.GetName())
}

func main() {
	MakeSound(Dog{"Dela"})
	MakeSound(Cat{})
	// MakeSound(Fish{})

	WhoAreU(Dog{"Nela"})
	// WhoAreU(Cat{})
	k := Komodo{"Dragon"}
	WhoAreU(k)
}
