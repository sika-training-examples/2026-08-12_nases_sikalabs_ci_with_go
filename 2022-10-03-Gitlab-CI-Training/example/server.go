package main

import (
	"fmt"
	"net/http"
	"os"
	"time"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "Hello World from Go! 💩💩💩 %s\n", hostname)
}

func main() {
	time.Sleep(15 * time.Second)
	http.HandleFunc("/", index)
	fmt.Println("Server started.")
	http.ListenAndServe(":80", nil)
}
