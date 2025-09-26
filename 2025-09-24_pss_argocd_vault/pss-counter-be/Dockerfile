FROM golang:1.25.1 AS build
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build

FROM debian:13-slim
COPY --from=build /build/pss-counter-be /usr/local/bin/pss-counter-be
CMD ["/usr/local/bin/pss-counter-be"]
EXPOSE 8000
