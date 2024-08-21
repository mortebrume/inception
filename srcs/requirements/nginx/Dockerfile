FROM alpine:3.19

RUN addgroup -g 101 -S nginx \
&& adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

RUN apk update && apk add --no-cache openssl nginx

RUN mkdir /docker-entrypoint.d \
&& mkdir /etc/nginx/ssl \
&& ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log \
&& rm -rf /etc/nginx/http.d/default.conf

RUN openssl req -x509 -newkey rsa:4096 \
-nodes -out /etc/nginx/ssl/42.crt \
-keyout /etc/nginx/ssl/42.key \
-days 365 \
-subj "/C=FR/O=Ecole 42/OU=42.fr/CN=aattali.42.fr"

COPY /aattali.42.fr.conf /etc/nginx/http.d
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 443

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]