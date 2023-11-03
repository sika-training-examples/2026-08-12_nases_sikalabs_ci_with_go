package main

import (
	"fmt"
	"net/http"
	"os"
	"log"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintf(w, "<center><h1>Hello World from Go! %s</h1></center>\n", hostname)
}

func main() {
	http.HandleFunc("/", index)
	fmt.Println("Server started.")
	err := http.ListenAndServe(":8000", nil)
	if err != nil {
		log.Fatalln(err)
	}
}
