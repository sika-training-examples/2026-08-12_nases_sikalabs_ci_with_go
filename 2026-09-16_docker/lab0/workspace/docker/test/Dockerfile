FROM golang:1.27 AS build
WORKDIR /build
COPY . .
RUN go build hello.go

FROM scratch
COPY --from=build /build/hello /usr/local/bin/hello
CMD ["/usr/local/bin/hello"]