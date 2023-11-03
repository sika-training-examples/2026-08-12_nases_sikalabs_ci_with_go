package main

import (
	"context"
	"fmt"

	"github.com/segmentio/kafka-go"
	"github.com/spf13/cobra"
)

var FlagBrokerAddr string
var FlagTopic string
var FlagGroupID string

var Cmd = &cobra.Command{
	Use:   "consumer",
	Short: "Example Kafka consumer",
	Run: func(cmd *cobra.Command, args []string) {
		ctx := context.Background()
		consume(ctx, FlagBrokerAddr, FlagTopic, FlagGroupID)
	},
}

func init() {
	Cmd.Flags().StringVarP(
		&FlagBrokerAddr,
		"broker-addr",
		"b",
		"",
		"Broker address",
	)
	Cmd.MarkFlagRequired("broker-addr")
	Cmd.Flags().StringVarP(
		&FlagTopic,
		"topic",
		"t",
		"",
		"Topic name",
	)
	Cmd.MarkFlagRequired("topic")
	Cmd.Flags().StringVarP(
		&FlagGroupID,
		"group-id",
		"g",
		"",
		"Consumer group ID",
	)
}

func main() {
	Cmd.Execute()
}

func consume(
	ctx context.Context,
	brokerAddr string,
	topic string,
	groupID string,
) {
	r := kafka.NewReader(kafka.ReaderConfig{
		Brokers: []string{brokerAddr},
		Topic:   topic,
		GroupID: groupID,
	})
	for {
		msg, err := r.ReadMessage(ctx)
		if err != nil {
			panic("could not read message " + err.Error())
		}
		fmt.Printf("consume: topic=%s key=%s msg=%s\n", topic, msg.Key, msg.Value)
	}
}
