FROM golang:1.19 as build
WORKDIR /app
COPY . .
ENV CGO_ENABLED=0
RUN go build app.go

FROM debian:11-slim
WORKDIR /app
COPY --from=build /app/app .
CMD ["./app"]
EXPOSE 80
