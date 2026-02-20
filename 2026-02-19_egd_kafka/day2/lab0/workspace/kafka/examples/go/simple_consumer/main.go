package main

import (
	"context"
	"fmt"
	"log"

	"github.com/segmentio/kafka-go"
)

const BROKER_ADDR = "98.67.131.154:29092"
const TOPIC = "egd2"
const GROUP_ID = "ondrej2"

func main() {
	r := kafka.NewReader(kafka.ReaderConfig{
		Brokers: []string{BROKER_ADDR},
		Topic:   TOPIC,
		GroupID: GROUP_ID,
	})

	for {
		msg, err := r.ReadMessage(context.Background())
		if err != nil {
			log.Fatalln(err)
		}
		fmt.Printf("consumed: key=%s msg=%s\n", msg.Key, msg.Value)
		// time.Sleep(500*time.Millisecond)
	}
}
