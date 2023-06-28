package create

import (
	"github.com/go-resty/resty/v2"
	"github.com/golang-training-examples/example2/internal/pets"
)

func CreatePet(origin string, name string, age int, kind string) error {
	pet := pets.Pet{
		Name: name,
		Age:  age,
		Kind: kind,
	}
	_, err := resty.New().R().SetBody(pet).Post(origin + "/pets")
	if err != nil {
		return nil
	}
	return nil
}
