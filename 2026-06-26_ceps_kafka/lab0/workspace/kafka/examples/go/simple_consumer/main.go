package main

import (
	"context"
	"fmt"
	"log"

	"github.com/segmentio/kafka-go"
)

const BROKER_ADDR = "127.0.0.1:9092"
const TOPIC = "simple"
const GROUP_ID = "simple_go"

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
	}
}
