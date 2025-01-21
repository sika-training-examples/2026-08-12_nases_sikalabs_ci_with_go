FROM golang:1.23 AS build
WORKDIR /app
COPY . .
RUN go build app.go

FROM debian:12-slim
WORKDIR /app
COPY --from=build /app/app .
CMD ["./app"]
EXPOSE 80
