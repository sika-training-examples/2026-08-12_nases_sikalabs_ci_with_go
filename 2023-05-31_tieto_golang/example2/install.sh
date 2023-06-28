#!/bin/sh

VERSION=v0.10.0 && \
OS=linux && \
ARCH=amd64 && \
OWNER=golang-training-examples && \
BIN=example2 && \
curl -fsSL https://github.com/${OWNER}/${BIN}/releases/download/${VERSION}/${BIN}_${VERSION}_${OS}_${ARCH}.tar.gz -o ${BIN}_${VERSION}_${OS}_${ARCH}.tar.gz && \
tar -xzf ${BIN}_${VERSION}_${OS}_${ARCH}.tar.gz ${BIN} && \
rm ${BIN}_${VERSION}_${OS}_${ARCH}.tar.gz && \
mv ${BIN} /usr/local/bin/
