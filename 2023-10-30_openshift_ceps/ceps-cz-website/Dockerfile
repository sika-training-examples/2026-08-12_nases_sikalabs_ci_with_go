FROM golang:1.21 as build
WORKDIR /build
COPY . .
ENV CGO_ENABLED=0
RUN go build

FROM scratch
WORKDIR /app
COPY --from=build /build/ceps-cz .
CMD ["./ceps-cz"]
EXPOSE 8000
