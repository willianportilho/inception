FROM alpine:3.17.3

RUN apk update && apk upgrade && apk add --no-cache nginx

EXPOSE 80

COPY ./requirements/nginx/tools/index.html /var/www/
COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
