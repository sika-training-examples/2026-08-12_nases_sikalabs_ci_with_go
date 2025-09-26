FROM golang:1.25 AS build
WORKDIR /build
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build .

FROM debian:13-slim
COPY --from=build /build/hello-pss /usr/local/bin/hello-pss
CMD ["/usr/local/bin/hello-pss"]
EXPOSE 8000
