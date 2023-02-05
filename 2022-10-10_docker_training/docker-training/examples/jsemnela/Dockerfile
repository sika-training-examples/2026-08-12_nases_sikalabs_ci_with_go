FROM node:16-slim as build
WORKDIR /build
COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .
RUN yarn run static

FROM nginx
COPY --from=build /build/out /usr/share/nginx/html
