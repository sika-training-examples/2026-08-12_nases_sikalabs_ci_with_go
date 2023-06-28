package main

import (
	"fmt"
	"struct_with_private_properties/pets"
)

func main() {
	dela := pets.Pet{}
	dela.SetName("Dela")
	fmt.Println(dela.Name())

	nela := pets.Pet{}
	pets.SetName(&nela, "Nela")
	fmt.Println(pets.Name(nela))
}
