FROM docker.io/library/golang:1.24 AS build
WORKDIR /build
COPY . .
ENV CGO_ENABLED=0
RUN \
  go build app.go

FROM scratch
COPY --from=build /build/app /
CMD ["/app"]
EXPOSE 80
