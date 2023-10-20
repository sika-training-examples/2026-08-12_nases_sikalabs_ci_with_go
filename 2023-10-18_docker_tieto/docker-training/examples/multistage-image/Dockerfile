FROM golang:1.21 as build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build app.go

FROM debian:12-slim
WORKDIR /app
COPY --from=build /app/app .
CMD ["./app"]
EXPOSE 80
