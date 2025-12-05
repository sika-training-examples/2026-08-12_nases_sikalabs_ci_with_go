FROM golang:1.25 AS build
WORKDIR /app
COPY . .
RUN \
  --mount=type=cache,target=/root/.cache/go-build \
  --mount=type=cache,target=/go \
  CGO_ENABLED=0 go build app.go

FROM scratch
WORKDIR /app
COPY --from=build /app/app .
CMD ["./app"]
EXPOSE 80
