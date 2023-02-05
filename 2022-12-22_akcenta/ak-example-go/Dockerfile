FROM golang:1.19 as build
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY main.go .
ENV CGO_ENABLED=0
RUN go build

FROM debian:11-slim
COPY --from=build /build/ak-example-go .
CMD ["/ak-example-go"]
EXPOSE 8000
