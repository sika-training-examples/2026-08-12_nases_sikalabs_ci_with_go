package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"

	"github.com/go-redis/redis/v8"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

type CounterResponse struct {
	Count    int    `json:"count"`
	Hostname string `json:"hostname"`
}

func main() {
	HOSTNAME, _ := os.Hostname()
	rdb := redis.NewClient(&redis.Options{
		Addr:     os.Getenv("REDIS_HOST") + ":6379",
		Password: "",
		DB:       0,
	})

	zerolog.TimeFieldFormat = zerolog.TimeFormatUnix

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		var err error
		ctx := context.Background()

		counter := 0
		val, err := rdb.Get(ctx, "counter").Result()
		if err != nil {
			log.Error().
				Str("hostname", HOSTNAME).
				Msg(fmt.Sprintf("error=%s", err))
		}
		counter, err = strconv.Atoi(val)
		if err != nil {
			log.Error().
				Str("hostname", HOSTNAME).
				Msg(fmt.Sprintf("error=%s", err))
		}

		data, _ := json.Marshal(CounterResponse{
			Count:    counter,
			Hostname: HOSTNAME,
		})
		w.Header().Set("Content-Type", "application/json")
		w.Write(data)
		log.Debug().
			Str("hostname", HOSTNAME).
			Msg(fmt.Sprintf("counter=%d", counter))

		err = rdb.Set(ctx, "counter", strconv.Itoa(counter+1), 0).Err()
		if err != nil {
			log.Error().
				Str("hostname", HOSTNAME).
				Msg(fmt.Sprintf("error=%s", err))
		}
	})
	http.HandleFunc("/favicon.ico", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusNotFound)
		w.Header().Set("Content-Type", "application/json")
	})
	log.Info().
		Str("hostname", HOSTNAME).
		Msg("Starting server on port :8000, http://127.0.0.1:8000")
	http.ListenAndServe(":8000", nil)
}
