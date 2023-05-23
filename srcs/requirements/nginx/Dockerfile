FROM alpine:3.17

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/wportilh.crt \
    -keyout /etc/nginx/ssl/wportilh.key \
    -subj "/C=FR/ST=PARIS/L=PARIS/O=42/OU=wportilh/CN=wportilh/"

EXPOSE 443

COPY ./requirements/nginx/tools/index.html /var/www/
COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
