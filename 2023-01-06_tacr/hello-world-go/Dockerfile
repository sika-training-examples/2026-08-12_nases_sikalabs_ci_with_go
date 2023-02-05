FROM golang:1.19 as build
WORKDIR /build
COPY go.mod main.go ./
ENV CGO_ENABLED=0
RUN go build

FROM scratch
WORKDIR /app
COPY --from=build /build/hello-world-go .
CMD ["./hello-world-go"]
EXPOSE 80
