FROM stakater/base-alpine:3.5

RUN apk --update add openssl

VOLUME /certs

WORKDIR /certs

COPY generate-certs /usr/local/bin/generate-certs

ENTRYPOINT ["/usr/local/bin/generate-certs"]


