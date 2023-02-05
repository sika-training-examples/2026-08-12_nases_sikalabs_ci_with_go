#!/bin/sh

if [ -z "$NAME" ]; then
  echo Environment variable NAME is required 1>&2
  exit 1
fi

echo "<h1>Hello $NAME</h1>" > /usr/share/nginx/html/index.html

exec /docker-entrypoint.sh "$@"
