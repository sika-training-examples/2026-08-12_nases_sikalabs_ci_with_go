FROM ghcr.io/sikalabs/ci
RUN slu s ins go
RUN ln -s /usr/local/go/bin/go /usr/bin/go
