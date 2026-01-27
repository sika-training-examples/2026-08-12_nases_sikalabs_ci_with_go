FROM rust:1 as build-env
WORKDIR /app
COPY . /app
RUN cargo build --release

FROM debian:12-slim
COPY --from=build-env /app/target/release/hello-world-distroless /
CMD ["./hello-world-distroless"]
