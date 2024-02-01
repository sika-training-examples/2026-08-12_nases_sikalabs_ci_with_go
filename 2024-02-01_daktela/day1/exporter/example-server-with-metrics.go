package main

import (
	"net/http"
	"time"

	"fmt"
	"log"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var counter = prometheus.NewCounter(
	prometheus.CounterOpts{
		Namespace: "example",
		Name:      "counter",
		Help:      "Number of requests",
	})

func main() {
	// Register request
	prometheus.MustRegister(counter)

	go func() {
		for {
			counter.Inc()
			time.Sleep(time.Second)
		}
	}()

	// Add /metrics endpoint
	http.Handle("/metrics", promhttp.Handler())

	fmt.Println("Server started. See http://127.0.0.1:8000")
	log.Fatal(http.ListenAndServe(":8000", nil))
}
