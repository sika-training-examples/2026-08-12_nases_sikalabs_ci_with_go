package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/segmentio/kafka-go"
)

const BROKER_ADDR = "kafka:9092"
const TOPIC = "example_simple"
const GROUP_ID = "example_simple"

func main() {
	for {
		partitions, err := kafka.LookupPartitions(context.Background(), "tcp", BROKER_ADDR, TOPIC)
		if err == nil && len(partitions) > 0 {
			break
		}
		log.Printf("waiting for topic %s: %v", TOPIC, err)
		time.Sleep(time.Second)
	}

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
