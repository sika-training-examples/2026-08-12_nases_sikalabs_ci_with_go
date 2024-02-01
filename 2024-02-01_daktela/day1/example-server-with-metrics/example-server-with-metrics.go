package main

import (
	"net/http"

	"fmt"
	"log"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var counter_requests = prometheus.NewCounterVec(
	prometheus.CounterOpts{
		Namespace: "example",
		Name:      "requests",
		Help:      "Number of requests",
	}, []string{"endpoint"})

func main() {
	// Register request
	prometheus.MustRegister(counter_requests)

	// Add /metrics endpoint
	http.Handle("/metrics", promhttp.Handler())

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		counter_requests.WithLabelValues("/").Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
	})

	http.HandleFunc("/favicon.ico", func(w http.ResponseWriter, r *http.Request) {
		counter_requests.WithLabelValues("/favicon.ico").Add(1)
		w.WriteHeader(404)
	})

	fmt.Println("Server started. See http://127.0.0.1:8000")
	log.Fatal(http.ListenAndServe(":8000", nil))
}
