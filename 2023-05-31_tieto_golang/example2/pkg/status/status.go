package status

import (
	"encoding/json"
	"fmt"
	"log"

	"github.com/go-resty/resty/v2"
	"github.com/golang-training-examples/example2/pkg/server"
)

func Status(origin string) (*server.StatusResponse, error) {
	resp, err := resty.New().R().Get(origin + "/status")
	if err != nil {
		return nil, err
	}

	if resp.StatusCode() != 200 {
		return nil, fmt.Errorf("status code is %d", resp.StatusCode())
	}

	var data server.StatusResponse
	err = json.Unmarshal([]byte(resp.Body()), &data)
	if err != nil {
		return nil, err
	}

	return &data, nil
}

func PrintStatusOrDie(origin string) {
	status, err := Status(origin)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf(`Hostname: %s
Started:  %d
Uptime:   %d
`,
		status.Hostname,
		status.StartedTimestamp,
		status.Uptime,
	)
}

func PrintStatusJsonOrDie(origin string) {
	status, err := Status(origin)
	if err != nil {
		log.Fatal(err)
	}

	data, _ := json.Marshal(status)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(string(data))
}
