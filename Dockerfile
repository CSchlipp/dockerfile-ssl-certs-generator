FROM alpine

RUN apk --update add bash openssl

VOLUME /certs

WORKDIR /certs

COPY generate-certs /usr/local/bin/generate-certs

ENTRYPOINT ["/usr/local/bin/generate-certs"]


