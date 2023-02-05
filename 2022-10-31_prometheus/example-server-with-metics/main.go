package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"os"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var exampleInfo = prometheus.NewGaugeVec(
	prometheus.GaugeOpts{
		Name: "example_info",
		Help: "Information about the server",
	}, []string{"hostname"},
)

var exampleRequestHistogram = prometheus.NewHistogramVec(
	prometheus.HistogramOpts{
		Name:    "example_request_duration_seconds",
		Help:    "A histogram of latencies for requests.",
		Buckets: []float64{0.05, 0.1, 0.3, 0.5, 1, 1.3, 1.7, 2, 5},
	},
	[]string{"path", "method", "status", "is_slow"},
)

func randomSleep() (bool, time.Duration) {
	isSlow := rand.Int()%2 == 0
	if isSlow {
		return isSlow, time.Duration(rand.Intn(1000))*time.Millisecond + time.Second
	} else {
		return isSlow, time.Duration(rand.Intn(1000)) * time.Millisecond
	}
}

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	isSlow, sleepDuration := randomSleep()
	exampleRequestHistogram.WithLabelValues(r.URL.Path, r.Method, "200", fmt.Sprintf("%t", isSlow)).Observe(sleepDuration.Seconds())

	fmt.Fprintf(w, "<h1>Hello World from Go! %s</h1>\n", hostname)
}

func main() {
	rand.Seed(time.Now().UnixNano())

	prometheus.MustRegister(exampleRequestHistogram)
	prometheus.MustRegister(exampleInfo)

	hostname, _ := os.Hostname()
	exampleInfo.WithLabelValues(hostname).Set(1)

	http.Handle("/metrics", promhttp.Handler())
	http.HandleFunc("/", index)
	fmt.Println("Server started.")
	http.ListenAndServe(":80", nil)
}
