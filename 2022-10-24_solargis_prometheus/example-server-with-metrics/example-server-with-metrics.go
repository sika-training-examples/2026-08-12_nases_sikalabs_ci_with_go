package main

import (
	"net/http"
	"time"

	"fmt"
	"log"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var counter_requests = prometheus.NewCounter(
	prometheus.CounterOpts{
		Namespace: "example",
		Name:      "requests",
		Help:      "Number of requests",
	})
var histogram_request_latency = prometheus.NewHistogram(prometheus.HistogramOpts{
	Namespace: "example",
	Name:      "request_duration_seconds",
	Help:      "Request duration in seconds",
	Buckets:   []float64{.01, .05, .1, .2, .5, 1, 2, 5},
})

func main() {
	// Register request
	prometheus.MustRegister(counter_requests)
	prometheus.MustRegister(histogram_request_latency)

	// Add /metrics endpoint
	http.Handle("/metrics", promhttp.Handler())

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		started := time.Now()
		counter_requests.Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
		histogram_request_latency.Observe(time.Since(started).Seconds())
	})

	http.HandleFunc("/sleep10", func(w http.ResponseWriter, r *http.Request) {
		started := time.Now()
		time.Sleep(5 * time.Millisecond)
		counter_requests.Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
		histogram_request_latency.Observe(time.Since(started).Seconds())
	})

	http.HandleFunc("/sleep50", func(w http.ResponseWriter, r *http.Request) {
		started := time.Now()
		time.Sleep(40 * time.Millisecond)
		counter_requests.Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
		histogram_request_latency.Observe(time.Since(started).Seconds())
	})

	http.HandleFunc("/sleep100", func(w http.ResponseWriter, r *http.Request) {
		started := time.Now()
		time.Sleep(90 * time.Millisecond)
		counter_requests.Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
		histogram_request_latency.Observe(time.Since(started).Seconds())
	})

	http.HandleFunc("/sleep200", func(w http.ResponseWriter, r *http.Request) {
		started := time.Now()
		time.Sleep(190 * time.Millisecond)
		counter_requests.Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
		histogram_request_latency.Observe(time.Since(started).Seconds())
	})

	http.HandleFunc("/sleep500", func(w http.ResponseWriter, r *http.Request) {
		started := time.Now()
		time.Sleep(400 * time.Millisecond)
		counter_requests.Add(1)
		w.WriteHeader(200)
		w.Write([]byte("OK"))
		histogram_request_latency.Observe(time.Since(started).Seconds())
	})

	fmt.Println("Server started.")
	log.Fatal(http.ListenAndServe(":80", nil))
}
