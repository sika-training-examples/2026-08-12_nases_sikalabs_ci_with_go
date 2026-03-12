package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	name := "World"
	if os.Getenv("NAME") != "" {
		name=os.Getenv("NAME")
	}
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintf(w, `<center><h1 style="color: red;">Hello `+name+` from Docker Compose! %s</h1></center>`, hostname)
}

func main() {
	port := "80"
	if os.Getenv("PORT") != "" {
		port=os.Getenv("PORT")
	}
	http.HandleFunc("/", index)
	fmt.Println("Server started on 0.0.0.0:"+port+", see http://127.0.0.1:"+port)
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatalln(err)
	}
}
