FROM golang as build
WORKDIR /build
COPY go.mod .
COPY go.sum .
COPY example-server-with-metrics.go .
RUN go get
ENV CGO_ENABLED=0
RUN go build -a -ldflags \
  '-extldflags "-static"' example-server-with-metrics.go

FROM scratch
COPY --from=build /build/example-server-with-metrics .
CMD ["/example-server-with-metrics"]
EXPOSE 80
