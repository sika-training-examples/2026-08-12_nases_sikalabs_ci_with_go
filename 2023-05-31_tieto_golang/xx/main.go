package main

import "fmt"

type Address struct {
	Street  string
	City    string
	ZIP     int
	Country string
}

type Person struct {
	Name string
	Address
}

type Person2 struct {
	Name string
	*Address
}

func main() {
	ondrej := Person{
		Name: "Ondrej Sika",
		Address: Address{
			Street:  "Klatovska 71",
			City:    "Plzen",
			ZIP:     30100,
			Country: "CZ",
		},
	}
	fmt.Println(ondrej)
	fmt.Printf(
		"%s, %s, %d %s, %s\n",
		ondrej.Name,
		ondrej.Street,
		ondrej.ZIP,
		ondrej.City,
		ondrej.Country,
	)

	dela := Person{
		Name: "Dela",
	}
	fmt.Println(dela)
	fmt.Printf(
		"%s, %s, %d %s, %s\n",
		dela.Name,
		dela.Street,
		dela.ZIP,
		dela.City,
		dela.Country,
	)

	ondrej2 := Person2{
		Name: "Ondrej Sika",
		Address: &Address{
			Street:  "Klatovska 71",
			City:    "Plzen",
			ZIP:     30100,
			Country: "CZ",
		},
	}
	fmt.Println(ondrej2)
	fmt.Printf(
		"%s, %s, %d %s, %s\n",
		ondrej2.Name,
		ondrej2.Street,
		ondrej2.ZIP,
		ondrej2.City,
		ondrej2.Country,
	)

	dela2 := Person2{
		Name: "Dela",
	}
	fmt.Println(dela2)
	if dela2.Address != nil {
		fmt.Printf(
			"%s, %s, %d %s, %s\n",
			dela2.Name,
			dela2.Street,
			dela2.ZIP,
			dela2.City,
			dela2.Country,
		)
	} else {
		fmt.Printf("%s has no address\n", dela.Name)
	}

}
