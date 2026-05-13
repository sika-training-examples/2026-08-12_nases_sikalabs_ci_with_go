FROM golang:1.26 AS build
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 go build app.go

FROM scratch
COPY --from=build /build/app /app
CMD [ "/app" ]
EXPOSE 80