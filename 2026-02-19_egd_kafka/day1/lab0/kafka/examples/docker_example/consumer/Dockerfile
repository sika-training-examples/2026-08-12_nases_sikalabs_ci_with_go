FROM golang:1.25 AS build
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY main.go ./
RUN go build

FROM debian:13-slim
COPY --from=build /build/consumer /usr/local/bin/consumer
CMD ["/usr/local/bin/consumer"]
