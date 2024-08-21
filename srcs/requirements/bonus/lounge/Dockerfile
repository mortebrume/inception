FROM alpine:3.19

RUN addgroup -g 1000 node && adduser -u 1000 -G node -s /bin/sh -D node

RUN apk --update --no-cache add nodejs npm

RUN npm install -g corepack

RUN corepack enable

ENV NODE_ENV production

ENV THELOUNGE_HOME "/var/opt/thelounge"
VOLUME "${THELOUNGE_HOME}"

ENV PORT 9000
EXPOSE ${PORT}

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["thelounge", "start"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN apk --update --no-cache --virtual build-deps add python3 build-base git && \
    ln -sf python3 /usr/bin/python && \
    yarn --non-interactive --frozen-lockfile global add thelounge@${THELOUNGE_VERSION} && \
    yarn --non-interactive cache clean && \
    apk del --purge build-deps && \
    rm -rf /root/.cache /tmp /usr/bin/python

RUN mkdir -p /var/opt/thelounge

COPY "config.js" /var/opt/thelounge
