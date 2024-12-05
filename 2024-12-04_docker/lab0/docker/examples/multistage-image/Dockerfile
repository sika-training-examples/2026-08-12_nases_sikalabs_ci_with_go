FROM golang:1.22 AS build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build app.go

FROM scratch
WORKDIR /app
COPY --from=build /app/app .
CMD ["./app"]
EXPOSE 80