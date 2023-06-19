package server

import (
	"example/hello"
	"fmt"
	"net/http"
	"os"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintf(w, "<h1>%s %s</h1>\n", hello.Hello("from CI"), hostname)
}

func Server() {
	http.HandleFunc("/", index)
	fmt.Println("Server started.")
	http.ListenAndServe(":8000", nil)
}
