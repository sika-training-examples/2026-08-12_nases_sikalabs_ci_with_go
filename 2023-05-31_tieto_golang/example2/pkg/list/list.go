package list

import (
	"encoding/json"
	"fmt"

	"github.com/go-resty/resty/v2"
	"github.com/golang-training-examples/example2/internal/pets"
)

func ListPets(origin string) ([]pets.Pet, error) {
	resp, err := resty.New().R().Get(origin + "/pets")
	if err != nil {
		return nil, err
	}

	if resp.StatusCode() != 200 {
		return nil, fmt.Errorf("status code is %d", resp.StatusCode())
	}

	var data []pets.Pet
	err = json.Unmarshal([]byte(resp.Body()), &data)
	if err != nil {
		return nil, err
	}

	return data, nil
}
