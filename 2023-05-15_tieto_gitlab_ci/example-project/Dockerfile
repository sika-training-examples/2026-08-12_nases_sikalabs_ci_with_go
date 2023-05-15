FROM golang:1.20 as build
WORKDIR /build
COPY go.mod main.go ./
ENV CGO_ENABLED=0
RUN go build

FROM scratch
WORKDIR /app
COPY --from=build /build/hello-tieto .
CMD ["./hello-tieto"]
EXPOSE 80
