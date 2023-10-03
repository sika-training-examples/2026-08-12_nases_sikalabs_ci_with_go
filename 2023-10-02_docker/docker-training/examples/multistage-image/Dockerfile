FROM golang:1.20 as build
WORKDIR /app
COPY . .
ENV CGO_ENABLED=0
RUN go build app.go

FROM scratch
WORKDIR /app
COPY --from=build /app/app .
CMD ["./app"]
EXPOSE 80
