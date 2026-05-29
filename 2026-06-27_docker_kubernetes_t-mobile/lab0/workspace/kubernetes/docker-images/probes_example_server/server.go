package main

import (
	"log"
	"net/http"
	"os"
	"strconv"
)

var LivenessProbeOK = true
var ReadinessProbeOK = true

func server() error {
	hostname, err := os.Hostname()
	if err != nil {
		log.Fatal(err)
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(200)
		w.Write([]byte("probes-example-server " + hostname +
			" liveness=" + strconv.FormatBool(LivenessProbeOK) +
			" readiness=" + strconv.FormatBool(ReadinessProbeOK) +
			"\n"))
	})

	http.HandleFunc("/livez", func(w http.ResponseWriter, r *http.Request) {
		if LivenessProbeOK {
			w.WriteHeader(200)
			w.Write([]byte("OK " + hostname + "\n"))
		} else {
			w.WriteHeader(500)
			w.Write([]byte("ERR " + hostname + "\n"))
		}
	})

	http.HandleFunc("/readyz", func(w http.ResponseWriter, r *http.Request) {
		if ReadinessProbeOK {
			w.WriteHeader(200)
			w.Write([]byte("OK " + hostname + "\n"))
		} else {
			w.WriteHeader(500)
			w.Write([]byte("ERR " + hostname + "\n"))
		}
	})

	http.HandleFunc("/api/fail-liveness", func(w http.ResponseWriter, r *http.Request) {
		LivenessProbeOK = false
		w.WriteHeader(200)
		w.Write([]byte("OK " + hostname + "\n"))
		log.Printf("[%s] fail liveness\n", hostname)
	})

	http.HandleFunc("/api/fail-readiness", func(w http.ResponseWriter, r *http.Request) {
		ReadinessProbeOK = false
		w.WriteHeader(200)
		w.Write([]byte("OK " + hostname + "\n"))
		log.Printf("[%s] fail readiness\n", hostname)
	})

	http.HandleFunc("/api/fix-readiness", func(w http.ResponseWriter, r *http.Request) {
		ReadinessProbeOK = true
		w.WriteHeader(200)
		w.Write([]byte("OK " + hostname + "\n"))
		log.Printf("[%s] fix readiness\n", hostname)
	})

	log.Printf("[%s] starting probes-example-server\n", hostname)
	log.Printf("[%s] Listening on 0.0.0.0:8000, see http://127.0.0.1:8000\n", hostname)
	return http.ListenAndServe(":8000", nil)
}
