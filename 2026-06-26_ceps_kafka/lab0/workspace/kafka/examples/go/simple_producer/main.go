package main

import (
	"context"
	"fmt"
	"log"
	"strconv"
	"time"

	"github.com/segmentio/kafka-go"
)

const BROKER_ADDR = "127.0.0.1:9092"
const TOPIC = "simple"

func main() {
	w := kafka.NewWriter(kafka.WriterConfig{
		Brokers: []string{BROKER_ADDR},
		Topic:   TOPIC,
	})

	for i := 0; ; i++ {
		key := strconv.Itoa(i)
		msg := "simple_go_" + strconv.Itoa(i)
		err := w.WriteMessages(context.Background(), kafka.Message{
			Key:   []byte(key),
			Value: []byte(msg),
		})
		if err != nil {
			log.Fatalln(err)
		}
		fmt.Printf("produced: key=%s msg=%s\n", key, msg)
		time.Sleep(time.Second)
	}
}
