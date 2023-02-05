FROM --platform=linux/amd64 node:16-slim
WORKDIR /build
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build
CMD [ "yarn", "start" ]
EXPOSE 3000
