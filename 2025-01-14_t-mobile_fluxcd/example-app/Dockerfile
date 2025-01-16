FROM golang:1.23.4 as build
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 go build

FROM debian:12-slim
WORKDIR /app
COPY --from=build /build/example .
CMD ["./example"]
EXPOSE 8000