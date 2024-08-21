FROM alpine:3.19

RUN addgroup -S -g 1000 redis \
    && adduser -S -G redis -u 999 redis

RUN apk update && apk add --no-cache tzdata redis

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY redis.conf /etc/redis.conf
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server", "/etc/redis.conf"]