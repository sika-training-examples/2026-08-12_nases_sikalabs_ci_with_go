FROM golang:1.24 AS build
WORKDIR /build
COPY . .
ENV CGO_ENABLED=0
RUN \
  --mount=type=cache,target=/root/.cache/go-build \
  --mount=type=cache,target=/go \
  go build

FROM scratch
COPY --from=build /build/server /
CMD ["/server"]
EXPOSE 80
