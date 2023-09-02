FROM golang:1.19 as builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY consumer.go ./
RUN CGO_ENABLED=0 go build

FROM debian:11-slim
WORKDIR /app
COPY --from=builder /build/consumer .
CMD ["./consumer"]
