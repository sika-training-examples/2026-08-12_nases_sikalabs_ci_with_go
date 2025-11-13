FROM golang:1.25 AS builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build

FROM debian:13-slim
COPY --from=builder /build/frontend /usr/local/bin/frontend
CMD [ "/usr/local/bin/frontend" ]
EXPOSE 3000
