FROM node:17 as build
WORKDIR /build
COPY package.json .
COPY yarn.lock .
RUN yarn
COPY . .
RUN yarn static

FROM nginx:alpine
COPY --from=build /build/out /usr/share/nginx/html
