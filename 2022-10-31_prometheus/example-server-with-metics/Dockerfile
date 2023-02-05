FROM golang:1.19 as build
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY main.go .
ENV CGO_ENABLED=0
RUN go build

FROM debian:11-slim
WORKDIR /app
COPY --from=build /build/example-server-with-metics .
CMD ["./example-server-with-metics"]
EXPOSE 80
