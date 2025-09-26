FROM golang:1.25.1 AS build
WORKDIR /build
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build .

FROM debian:13-slim
COPY --from=build /build/pss-counter-fe /usr/local/bin/pss-counter-fe
CMD ["/usr/local/bin/pss-counter-fe"]
EXPOSE 3000
