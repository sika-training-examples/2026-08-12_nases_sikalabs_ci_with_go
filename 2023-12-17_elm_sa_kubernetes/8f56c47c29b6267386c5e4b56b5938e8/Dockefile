FROM golang:1.21 as build
WORKDIR /build
COPY main.go .
ENV CGO_ENABLED=0
RUN go build main.go

FROM debian:stable-slim
WORKDIR /app
COPY --from=build /build/main .
CMD ["./main"]
EXPOSE 8080
