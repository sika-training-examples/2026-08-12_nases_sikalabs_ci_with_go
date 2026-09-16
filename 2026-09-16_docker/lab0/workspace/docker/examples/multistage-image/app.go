package main

import (
	"fmt"
	"net/http"
	"io"
)

func main(){
		resp, err := http.Get("https://checkip.amazonaws.com/")
		if err != nil {
			panic(err)
		}
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			panic(err)
		}
		defer resp.Body.Close()

		fmt.Println(string(body))
}