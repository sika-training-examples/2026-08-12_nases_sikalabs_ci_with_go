FROM golang:1.22 as build
WORKDIR /app
COPY app.go .
ENV CGO_ENABLED=0
RUN go build app.go

FROM debian:12-slim
COPY --from=build /app/app /usr/local/bin/app
CMD ["/usr/local/bin/app"]
EXPOSE 80
