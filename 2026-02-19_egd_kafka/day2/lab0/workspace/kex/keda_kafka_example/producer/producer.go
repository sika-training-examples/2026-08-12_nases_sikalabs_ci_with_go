package main

import (
	"context"
	"fmt"
	"os"
	"strconv"
	"time"

	"github.com/segmentio/kafka-go"
)

func main() {
	ctx := context.Background()
	brokerAddress := os.Getenv("KAFKA_BROKER_ADDRESS")
	topic := os.Getenv("KAFKA_TOPIC")
	text := os.Getenv("TEXT")
	produce(ctx, brokerAddress, topic, text)
}

func produce(
	ctx context.Context,
	brokerAddr string,
	topic string,
	text string,
) {
	w := kafka.NewWriter(kafka.WriterConfig{
		Brokers: []string{brokerAddr},
		Topic:   topic,
	})

	i := 0
	var key string
	var msg string

	hostname, _ := os.Hostname()

	for {
		key = strconv.Itoa(i)
		if text == "" {
			text = "Hello"
		}
		msg = "[" + hostname + "] " + text + " " + strconv.Itoa(i)
		err := w.WriteMessages(ctx, kafka.Message{
			Key:   []byte(key),
			Value: []byte(msg),
		})
		if err != nil {
			panic("could not write message " + err.Error())
		}
		fmt.Printf("produce: topic=%s key=%s msg=%s\n", topic, key, msg)
		i++
		time.Sleep(time.Second)
	}
}
