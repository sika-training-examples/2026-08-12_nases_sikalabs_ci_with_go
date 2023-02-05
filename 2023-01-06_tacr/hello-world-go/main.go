package main

import (
	"fmt"
	"net/http"
	"os"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "<body><center><h1>Hello World from Go! %s</h1></center></body>\n", hostname)
	// fmt.Fprintf(w, "<h1><center>Hello World from Go! %s</center></h1>\n", hostname)
}

func main() {
	http.HandleFunc("/", index)
	fmt.Println("Server started on 0.0.0.0:80, url: http://127.0.0.1:80")
	http.ListenAndServe(":80", nil)
}
