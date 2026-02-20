package main

import (
	"context"
	"fmt"
	"log"
	"strconv"
	"time"

	"github.com/segmentio/kafka-go"
)

const TOPIC = "egd2"

func main() {
	w := kafka.NewWriter(kafka.WriterConfig{
		Brokers: []string{
			"98.67.144.10:29093",
			"20.79.96.130:29093",
			"9.141.100.14:29093",
		},
		Topic: TOPIC,
	})

	for i := 0; ; i++ {
		key := strconv.Itoa(i)
		msg := "hello EGD form Ondrej " + strconv.Itoa(i)
		err := w.WriteMessages(context.Background(), kafka.Message{
			Key:   []byte(key),
			Value: []byte(msg),
		})
		if err != nil {
			log.Fatalln(err)
		}
		fmt.Printf("produced: key=%s msg=%s\n", key, msg)
		time.Sleep(10 * time.Millisecond)
	}
}
