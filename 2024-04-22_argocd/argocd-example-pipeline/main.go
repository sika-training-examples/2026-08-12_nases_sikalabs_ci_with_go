package main

import (
	"fmt"
	"net/http"
	"os"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "<h1><center>Hello ArgoCD from Go! %s</center></h1>\n", hostname)
	fmt.Fprintf(w, "Hello ArgoCD from Go! %s</center>\n", hostname)
}

func main() {
	http.HandleFunc("/", index)
	fmt.Println("Server started.")
	http.ListenAndServe(":80", nil)
}
