FROM golang:1.21.6 as build
WORKDIR /build
COPY main.go go.mod ./
ENV CGO_ENABLED=0
RUN go build

FROM scratch
COPY --from=build /build/server .
CMD ["/server"]
EXPOSE 80
