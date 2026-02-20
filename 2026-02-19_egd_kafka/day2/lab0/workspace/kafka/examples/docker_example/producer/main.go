package main

import (
	"context"
	"fmt"
	"log"
	"strconv"
	"time"

	"github.com/segmentio/kafka-go"
)

func main() {
	w := &kafka.Writer{
		Addr:  kafka.TCP("kafka:9092"),
		Topic: "example_simple",
	}

	for i := 0; ; i++ {
	send:
		key := strconv.Itoa(i)
		msg := "docker_" + strconv.Itoa(i)
		err := w.WriteMessages(context.Background(), kafka.Message{
			Key:   []byte(key),
			Value: []byte(msg),
		})
		if err != nil {
			log.Println(err)
			time.Sleep(time.Second)
			goto send
		}
		fmt.Printf("produced: key=%s msg=%s\n", key, msg)
		time.Sleep(time.Second)
	}
}
