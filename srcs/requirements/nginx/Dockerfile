FROM alpine:3.17

# install required dependencies
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# creates ssl directory
RUN mkdir /etc/nginx/ssl

# request for a new RSA key (4096 bits); self-signed certificate (x509);
# signed with the sha256 algorithm; expires in 365 days; private key unencrypted (nodes)
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/wportilh.crt \
    -keyout /etc/nginx/ssl/wportilh.key \
    -subj "/C=FR/ST=PARIS/L=PARIS/O=42/OU=wportilh/CN=wportilh/"

# exposes 443 default ssl/tls port
EXPOSE 443

# copies nginx.conf into the container
COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/http.d/

# runs nginx in the foreground, allowing it to remain active while the container is running
CMD ["nginx", "-g", "daemon off;"]
