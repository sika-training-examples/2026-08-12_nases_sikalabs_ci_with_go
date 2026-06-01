FROM node:24-trixie-slim AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN --mount=type=cache,target=/root/.yarn \
    YARN_CACHE_FOLDER=/root/.yarn yarn install
COPY . .
RUN --mount=type=cache,target=/app/.next/cache \
    yarn build

FROM gcr.io/distroless/nodejs24-debian13
WORKDIR /app
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/.next /app/.next
ENV NODE_ENV=production
CMD ["/app/node_modules/.bin/next", "start"]
EXPOSE 3000
