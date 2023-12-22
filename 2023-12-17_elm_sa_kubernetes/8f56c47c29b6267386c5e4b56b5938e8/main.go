package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Make a request to the API
		resp, err := http.Get(os.Getenv("API_URL"))
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer resp.Body.Close()

		// Read the response
		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Create an HTML response with the API response in <h1> tag
		fmt.Fprintf(w, "<h1>%s</h1>", string(body))
	})

	// Start the server
	log.Fatal(http.ListenAndServe(":8080", nil))
}
