FROM golang:1.20 as build
WORKDIR /build
COPY app.go .
ENV CGO_ENABLED=0
RUN go build app.go

FROM busybox
WORKDIR /app
COPY --from=build /build/app .
CMD ["./app"]
EXPOSE 8000
