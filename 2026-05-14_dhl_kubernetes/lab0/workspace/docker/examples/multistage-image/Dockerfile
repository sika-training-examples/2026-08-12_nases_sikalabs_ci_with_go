FROM golang:1.26 AS build-stage
WORKDIR /build-dir
COPY . .
RUN CGO_ENABLED=0 go build app.go -o /targer

FROM scratch
COPY --from=build-stage /targer /app
CMD [ "/app" ]
EXPOSE 80