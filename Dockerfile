FROM alpine:3.4

MAINTAINER toph <toph@toph.fr>

RUN apk add --no-cache ruby ruby-bigdecimal sqlite-libs libstdc++ ca-certificates

ENV MAILCATCHER_VERSION 0.6.5

RUN apk add --no-cache --virtual .build-deps \
        ruby-dev \
        make g++ \
        sqlite-dev \
        && \
    gem install json --no-rdoc --no-ri && \
    gem install -v $MAILCATCHER_VERSION mailcatcher --no-ri --no-rdoc && \
    apk del .build-deps

RUN rm -rf /var/cache/apk/*

EXPOSE 25 80

CMD ["mailcatcher", "--foreground", "--ip=0.0.0.0", "--smtp-port=25", "--http-port=80"]
