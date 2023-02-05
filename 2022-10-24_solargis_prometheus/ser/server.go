package main

import (
	"math/rand"
	"net/http"
	"strconv"
	"time"

	"fmt"
	"log"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var info = prometheus.NewGaugeVec(
	prometheus.GaugeOpts{
		Namespace: "example",
		Name:      "info",
		Help:      "Runtime information about the server.",
	}, []string{"started_at"})

var requests = prometheus.NewHistogramVec(
	prometheus.HistogramOpts{
		Namespace: "example",
		Name:      "requests",
		Help:      "Request latency in seconds.",
		Buckets:   []float64{0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2},
	},
	[]string{"method", "path", "status_code"},
)

func getStatusCode() int {
	status_codes := []int{
		200,
		200,
		200,
		200,
		500,
	}
	n := rand.Int() % len(status_codes)
	return status_codes[n]
}

func getSleepTime() int {
	times := []int{
		30,
		30,
		30,
		30,
		200,
		200,
		1000,
	}
	n := rand.Int() % len(times)
	return times[n]
}

func main() {
	rand.Seed(time.Now().Unix())

	prometheus.MustRegister(info)
	prometheus.MustRegister(requests)

	now := time.Now()
	info.WithLabelValues(now.String()).Set(1)

	http.Handle("/metrics", promhttp.Handler())

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		status := getStatusCode()
		start := time.Now()
		w.WriteHeader(status)
		w.Write([]byte("OK\n"))
		sleepTime := getSleepTime()
		if status == 500 {
			if rand.Int()%10 == 0 {
				sleepTime = 2000
			} else {
				sleepTime = 0
			}
		}
		time.Sleep(time.Duration(sleepTime) * time.Millisecond)

		requests.WithLabelValues(r.Method, r.URL.Path, strconv.Itoa(status)).Observe(time.Since(start).Seconds())
	})

	fmt.Println("Server started.")
	log.Fatal(http.ListenAndServe(":80", nil))
}
