FROM golang:1.26 AS build
WORKDIR /build
COPY . .
ENV CGO_ENABLED=0
RUN go build

FROM debian:13-slim
COPY --from=build /build/probes_example_server /
RUN ln -sf /probes_example_server /usr/local/bin/http
CMD ["/probes_example_server", "server"]
EXPOSE 8000
